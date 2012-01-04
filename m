From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: how to enumerate useful ALSA devices?
Date: Wed, 04 Jan 2012 23:16:58 +0200
Message-ID: <4F04C1CA.7070000@iki.fi>
References: <20120104194956.GB9868@foghorn.codeweavers.com>
	<4F04BAF8.6010701@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw-out1.cc.tut.fi (mail-gw-out1.cc.tut.fi [130.230.160.32])
	by alsa0.perex.cz (Postfix) with ESMTP id D7F811038ED
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 22:17:06 +0100 (CET)
In-Reply-To: <4F04BAF8.6010701@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Eikum <aeikum@codeweavers.com>
Cc: alsa-devel@alsa-project.org, Joerg-Cyril.Hoehle@t-systems.com
List-Id: alsa-devel@alsa-project.org

On 04.01.2012 22:47, Anssi Hannula wrote:
> On 04.01.2012 21:49, Andrew Eikum wrote:
>> But, passing these to aplay fails if I have PulseAudio running
>> ("device in use").
> 
> Correct. You need to use pulse directly or the default/pulse device
> which passes audio to pulseaudio.

For the record, pulseaudio does release the device by default after it
has been unused for a few seconds. Not that it matters much here, though.

>> So I'm really stuck here. Where am I supposed to get a list of devices
>> that I can present to the user, including their Bluetooth devices and
>> virtual devices from asound.conf?
> 
> I guess the preferred one is 'snd_device_name_hint()', but I don't
> really know if the caller is supposed to then handle surroundXX stuff
> themself.

Reading your last reply made me realize that I forgot that when
pulseaudio is not configured, there is also the "default:CARD=foo"
device listed (which you noticed), so I guess one could just ignore
entries beginning with "front:" or "surround(40|41|50|51|71):", since
one can just use "default" instead of them.

-- 
Anssi Hannula
