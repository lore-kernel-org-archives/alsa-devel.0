From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: snd_ctl_elem_write fails -EPERM if snd_pcm is open
Date: Tue, 15 Apr 2008 20:33:13 +0200
Message-ID: <4804F4E9.2080803@insite.cz>
References: <6601CF63C167F44A9A9E97E41EE4B16C685945@CLUSTEREX.corporate.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C913103837
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 20:33:20 +0200 (CEST)
In-Reply-To: <6601CF63C167F44A9A9E97E41EE4B16C685945@CLUSTEREX.corporate.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Bouterse, Bob" <bob.bouterse@dm-holdings-na.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Bouterse, Bob wrote:
> I am trying to sent IEC958 status bits on a VT1708A HAD-INTEL codec
> while audio is being output.
> snd_ctl_elem_write returns -EPERM from
> linux-2.6.24.3/sound/core/control.c:769 .
>  
> Is there some way I can do this?
>  
> FYI using iecset will also give you an:
> # iecset copywrite on
> snd_ctl_elem_write: Operation not permitted
>  
> I am using alsa-lib-1.0.14a

Hi,

I guess the reason is in /usr/share/alsa/cards/HDA-Intel.conf . If I 
understand correctly, upon opening the iec958 stream, the status bits 
control gets locked

..........
			hook_args [
			{
				name "IEC958 Playback Default"
				lock true
				preserve true
				value [ $AES0 $AES1 $AES2 $AES3 ]
			}
...........

The same applies to a number of other cards.

Pavel.
