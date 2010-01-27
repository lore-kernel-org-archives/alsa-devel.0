From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Support for floating point controls?
Date: Thu, 28 Jan 2010 12:12:01 +1300
Message-ID: <4B60C841.9010306@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 7ACB81037F9
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 00:12:05 +0100 (CET)
Received: from [192.168.1.6]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KWX00HPQHS3R110@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 28 Jan 2010 12:12:03 +1300 (NZDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Greetings,

some of our products now have control paramters that are 32 bit floating
point values.

I wonder if a patch implementing float ctl elements would be accepted?
Note that the floats are not manipulated in the kernel at all, the
values are just passed through from the hardware to userspace (?)

Adding something like:

#define	SNDRV_CTL_ELEM_TYPE_FLOAT	((__force snd_ctl_elem_type_t) 7)

struct snd_ctl_elem_info {
...
  union {
	struct {
		float min;		/* R: minimum value */
		float max;		/* R: maximum value */
		float step;		/* R: step (0 variable) */
	} float;
...
}

struct snd_ctl_elem_value {
  union {
	union {
		float value[128];
	} float;


--
Eliot Blennerhassett
AudioScience Inc
