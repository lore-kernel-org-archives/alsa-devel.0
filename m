From: CAG <cag@fsk-hh.org>
Subject: Re: M-Delta Audiophile 192 (ice1724) Recording
Date: Wed, 30 Jan 2008 14:52:24 +0100
Message-ID: <47A08118.9080107@fsk-hh.org>
References: <479DCA8C.7070209@fsk-hh.org> <s5h7ihr4ivs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.nadir.org (mail.nadir.org [217.114.68.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 467AB24724
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 14:54:01 +0100 (CET)
In-Reply-To: <s5h7ihr4ivs.wl%tiwai@suse.de>
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

see http://pastebin.ca/884589

hope that helps. Do you need anything else ?

Thanks T.

Takashi Iwai schrieb:
> At Mon, 28 Jan 2008 13:29:00 +0100,
> CAG wrote:
>> Hi,
>>
>> we use the M-Delta Audiophile 192 with alsa-driver-1.0.15 and the 
>> ice1724 module. Playback works but we cannot record anything.
>>
>> I noticed that this maybe a bug according to the Alsa Changelog:
>>
>>  From Changes v1.0.13 v1.0.14:
>>  >
>>  >  - ice1724 - Add support of M-Audio Audiophile 192
>>  >
>>  >     Added the (experimental) support of M-Audio Audiophile 192 board.
>>  >     Currently, the analog and the digital playbacks seem working fine.
>>  >     The inputs seem not working as far as I've tested yet.
>>
>> How is the status for that card ? Is someone working on this ? I heard 
>> Recording with OSS works but actually we don't want to switch to OSS...
>> Is it worth waiting for a new release ?
> 
> No one is working on this board, AFAIK.  I made it a patch from some
> floating information.  But, since I have no hardware, I forgot this
> after pushing it to the upstream.
> 
> Basically, the analog input doesn't need so much initialization
> because the codec chip AK5385A has no software control.  Maybe the
> EEPROM setup isn't correct for the actual board configuration.
> (It means, BTW, that you have no input volume control, too.)
> 
> Show /proc/asound/card*/ice1724, and let's check the values there.
> 
> 
> Takashi
