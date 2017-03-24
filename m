From: Mark Hills <mark@xwax.org>
Subject: Regressions on x86(_64) and >128 mixer controls
Date: Fri, 24 Mar 2017 11:22:18 +0000 (GMT)
Message-ID: <1703241029200.20580@stax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C5D2668D2
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 12:22:19 +0100 (CET)
Received: from cpc93786-hari17-2-0-cust2676.20-2.cable.virginm.net
 ([82.36.106.117] helo=stax.localdomain)
 by jazz.pogo.org.uk with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.88 (FreeBSD)) (envelope-from <mark@xwax.org>)
 id 1crNIQ-00065F-Mw
 for alsa-devel@alsa-project.org; Fri, 24 Mar 2017 11:22:18 +0000
Received: from mark (helo=localhost)
 by stax.localdomain with local-esmtp (Exim 4.84)
 (envelope-from <mark@xwax.org>) id 1crNIQ-0000aD-7r
 for alsa-devel@alsa-project.org; Fri, 24 Mar 2017 11:22:18 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have an echo3g (Layla) PCI soundcard on x86_64. alsamixer and alsactl 
fail with the following:

  alsactl: control.c:2976: snd_ctl_elem_value_get_integer: Assertion `idx < ARRAY_SIZE(obj->value.integer.value)' failed.

In question is idx=128, and this "value" array in alsa-lib:

  struct snd_ctl_elem_value {
          struct snd_ctl_elem_id id;    /* W: element ID */
          unsigned int indirect: 1;     /* W: indirect access - obsoleted */
          union {
                  union {
                          long value[128];
                          long *value_ptr;        /* obsoleted */
                  } integer;  

At first it appears just to be hitting the fixed limit of 128.

However, this used to work -- and at the time I was using 32-bit kernel 
and userland on an otherwise similar system (not they are both 64-bit)

Increasing the array size cascades to a new problem which suggests these 
controls don't actually exist:

  ./alsactl/alsactl: get_control:258: Cannot read control '2,0,0,PCM Playback Volume,0': Inappropriate ioctl for device

So I investigated the origin of this 256, which is here in 
linux/sound/pci/echoaudio/echoaudio.c:

  static int snd_echo_mixer_info(struct snd_kcontrol *kcontrol,
                                 struct snd_ctl_elem_info *uinfo)
  {
          struct echoaudio *chip;

          chip = snd_kcontrol_chip(kcontrol);
          uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
          uinfo->value.integer.min = ECHOGAIN_MINOUT;
          uinfo->value.integer.max = ECHOGAIN_MAXOUT;
          uinfo->dimen.d[0] = num_busses_out(chip);              /* = 16 */
          uinfo->dimen.d[1] = num_busses_in(chip);               /* = 16 */
          uinfo->count = uinfo->dimen.d[0] * uinfo->dimen.d[1];  /* = 256 */
          return 0;
  }

These values are derived from constants in the source code for this 
Layla3G device; I can find nothing on this path that would cause variation 
between a 32-bit and 64-bit kernel -- the code suggests like this value 
has always been 256 in the kernel, so I can't come up with a reason that 
it could vary. I don't have enough knowledge of the hardware to know if 
256 /is/ the correct value here.

Something which may be related happened for a period when I was using 
32-bit userland with 64-bit kernel. This broke a number of tools (incl. 
echomixer)

Compare alsa-lib/include/alsa/asound.h:

  struct snd_ctl_elem_info {
          struct snd_ctl_elem_id id;      /* W: element ID */
          snd_ctl_elem_type_t type;       /* R: value type - SNDRV_CTL_ELEM_TYPE_* */
          unsigned int access;            /* R: value access (bitmask) - SNDRV_CTL_ELEM_ACCESS_* */
          unsigned int count;             /* count of values */
          __kernel_pid_t owner;           /* owner's PID of this control */
          union {
                  struct {
                          long min;               /* R: minimum value */
                          long max;               /* R: maximum value */
                          long step;              /* R: step (0 variable) */
                  } integer;

and notice the use of 'long' in this struct. It has a 
shadow/equivalent/identical in linux/uapi/sound/asound.h, copied to 
userland, using:

 	if (ioctl(hw->fd, SNDRV_CTL_IOCTL_ELEM_INFO, info) < 0)
		return -errno;

The kernel and userland can have different interpretations of 'long';
do these really not need to be the 'int' type?

Though maybe I am missing something -- surely I am not the only person to 
have used a 32-bit userland on a 64-bit kernel?

-- 
Mark
