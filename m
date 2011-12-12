From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] plug: Move fast_ops copy after slave
	configuration.
Date: Mon, 12 Dec 2011 08:18:17 +0800
Message-ID: <CAN8cciZ3Z7OJm5SdGZ3oR_MbpZ45-UYyrAz_vkdL9yaZQmuteg@mail.gmail.com>
References: <4EE507BC.7050603@qotw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7421D244C9
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 01:18:19 +0100 (CET)
Received: by wgbdr1 with SMTP id dr1so7087117wgb.20
	for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2011 16:18:17 -0800 (PST)
In-Reply-To: <4EE507BC.7050603@qotw.net>
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

2011/12/12 Reilly Grant <reillyeon@qotw.net>:

>
> This fixes a crash when two instances of plug are instantiated back to
> back and the format conversion plugin inserted by the second is skipped
> by the first because the fast_ops pointer is not properly updated. This
> is the case for applications requesting plug:default on Intel HDA chips.

The card 's "default" device of snd-hda-intel should be "plug:dmix"

you don't need to use "plug:default"

http://git.alsa-project.org/?p=alsa-lib.git;a=blob_plain;f=src/conf/cards/HDA-Intel.conf


# default with dmix+softvol & dsnoop
HDA-Intel.pcm.default {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type asym
	playback.pcm {
		type plug
		slave.pcm {
			type softvol
			slave.pcm {
				@func concat
				strings [ "dmix:" $CARD ]
			}
			control {
				name "PCM Playback Volume"
				card $CARD
			}
		}
	}
	capture.pcm {
		type plug
		slave.pcm {
			type softvol
			slave.pcm {
				@func concat
				strings [ "dsnoop:" $CARD ]
			}
			control {
				name "Digital Capture Volume"
				card $CARD
			}
			min_dB -30.0
			max_dB 30.0
			resolution 121
		}
		# to avoid possible phase inversions with digital mics
		route_policy copy
	}
	hint.device 0
}
