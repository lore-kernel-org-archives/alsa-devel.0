From: Gregoire ETIENNE <gregoire.etienne@parrot.com>
Subject: Listing up to 8 PCM devices
Date: Wed, 19 Nov 2008 08:19:21 +0000 (UTC)
Message-ID: <loom.20081119T075927-0@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B7E3245D4
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 09:20:04 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1L2iI7-0004zu-1k
	for alsa-devel@alsa-project.org; Wed, 19 Nov 2008 08:20:03 +0000
Received: from ASt-Lambert-152-1-44-55.w82-124.abo.wanadoo.fr ([82.124.170.55])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 08:20:03 +0000
Received: from gregoire.etienne by
	ASt-Lambert-152-1-44-55.w82-124.abo.wanadoo.fr with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 08:20:03 +0000
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

Hi,

I'm currently writting a driver with up to 8 pcm devices, so I turned on
"Dynamic device file minor numbers" option. But when I try to list devices
through aplay or a record (which are calling ioctl with cmd
SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE) I can only list devices from 0 to 7. This is
due to this code :

linux/sound/core/pcm.c l.64
------------------------------
	case SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE:
		{
			int device;

			if (get_user(device, (int __user *)arg))
				return -EFAULT;
			mutex_lock(&register_mutex);
			device = device < 0 ? 0 : device + 1;
			while (device < SNDRV_PCM_DEVICES) {
				if (snd_pcm_search(card, device))
					break;
				device++;
			}
			if (device == SNDRV_PCM_DEVICES)
				device = -1;
			mutex_unlock(&register_mutex);
			if (put_user(device, (int __user *)arg))
				return -EFAULT;
			return 0;
		}
------------------------------
because SNDRV_PCM_DEVICES is defined to 8 and do not change even if I selected
"Dynamic device file minor numbers" option.

Is there anything I missed ?
