From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: wrong decibel data?
Date: Thu, 27 May 2010 15:48:48 +0200
Message-ID: <4BFE7840.4070004@ladisch.de>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>	<hp744t$5b5$1@dough.gmane.org>	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>	<hqbv5m$cmf$1@dough.gmane.org>	<g2t4f3252891004201932k53dae8a1me8f7e968f8a28b5b@mail.gmail.com>	<hqmbmm$hsj$1@dough.gmane.org>	<i2r4f3252891004211816ldfedff21nfe61537043c9b22f@mail.gmail.com>
	<htls4d$phr$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 150EE103A6C
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 15:48:52 +0200 (CEST)
In-Reply-To: <htls4d$phr$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Guthrie wrote:
> state.Intel {
> 	control.1 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.count 2
> 		comment.range '0 - 31'
> 		comment.dbmin -4650
> 		comment.dbmax 0
> 		iface MIXER
> 		name 'Master Playback Volume'
> 		value.0 30
> 		value.1 30
> 	}

This is the hardware volume control.

> 	control.11 {
> 		comment.access 'read write user'
> 		comment.type INTEGER
> 		comment.count 2
> 		comment.range '0 - 255'
> 		comment.tlv '0000000100000008ffffec1400000014'
> 		comment.dbmin -5100
> 		comment.dbmax 0
> 		iface MIXER
> 		name 'PCM Playback Volume'
> 		value.0 253
> 		value.1 253
> 	}

This is the emulated software volume control that is created by the
softvol plugin.  This control gets recreated by "alsactl restore" even
when the plugin is not running.

Might it be possible that PA is trying to use this, but that it doesn't
have any effect because PA is using PCM device hw:0?  (Try unloading
snd-hda-intel and then deleting that entry from /etc/asound.state.)


Regards,
Clemens
