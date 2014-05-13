From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Wed, 14 May 2014 00:50:55 +0300
Message-ID: <537293BF.20900@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>	<loom.20131122T215246-90@post.gmane.org>	<529004F8.7070801@iki.fi>	<20131123154009.6c8c6e97@symphony.aura-online.co.uk>	<5290CD7C.7020907@iki.fi>	<20131124145737.22056256@symphony.aura-online.co.uk>	<52934E97.9060701@iki.fi>	<20131125143228.55c94550@red>	<52936537.8020506@iki.fi>	<20140513130126.1755fa16@red.yakaraplc.local>	<53720FC3.7000608@iki.fi>	<20140513171617.4d303844@red.yakaraplc.local>
 <20140513221056.0637c51d@symphony.aura-online.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F3E0261A0A
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 23:51:00 +0200 (CEST)
In-Reply-To: <20140513221056.0637c51d@symphony.aura-online.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexander.deucher@amd.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, James Le Cuirot <chewi@aura-online.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Alex,

14.05.2014 00:10, James Le Cuirot kirjoitti:
> On Tue, 13 May 2014 17:16:17 +0100
> James Le Cuirot <chewi@aura-online.co.uk> wrote:
> 
>> On Tue, 13 May 2014 15:27:47 +0300
>> Anssi Hannula <anssi.hannula@iki.fi> wrote:
>>
>>> Unfortunately I've been told that HD 4xxx cards and older do not
>>> support multichannel playback, which I didn't know at the time (and
>>> I had forgotten your case, hence I didn't get back to you - sorry
>>> about that).
>>
>> Thank you for the quick reply. I'm not sure whether that's strictly
>> true. Wikipedia (though not always correct, I grant you) states that:
>>
>> "The RV770 series GPU also supports xvYCC color space output and 7.1
>> surround sound output (LPCM, AC3, DTS) over HDMI."
>>
>> http://en.wikipedia.org/wiki/Radeon_HD_4000_Series#Multimedia_features
>>
>> The HD 4670 has the RV730XT chip. It isn't clear in the above
>> statement whether it is referring to the higher models in the range
>> or the range as a whole, given that the RV770 is the foundation chip.
>> Based on my experiences and what you have heard, it's probably the
>> former. This news piece at AnandTech also seems to back it up.
>>
>> "All of AMD's Radeon HD graphics cards have shipped with their own
>> audio codec, but the Radeon HD 4800 series of cards finally adds
>> support for 8-channel LPCM output over HDMI."
>>
>> http://www.anandtech.com/show/2556
>>
>> Looks like a new card for me then. Thanks for your help.
> 
> Aaaand after all that, I dig out the box for the old card to get ready
> to sell it and what do I see printed on the front? 7.1 Channel Sound!
> The box looks almost identical to this one:
> 
> http://www.overclockers.ua/video/ati-radeon-hd4670-ddr4/01-ati-radeon-hd4670-sapphire.jpg
> 
> This is very confusing. Any thoughts?

Alex, you told me in IRC some time ago that pre-DCE4 cards do no support
multi-channel PCM. Do you know what is going on above?
AFAIU James has HD 4670, which is RV730 and therefore has DCE3.2 only,
but seems like it should still have multi-channel support.

Multichannel LPCM support seems to be corroborated by various other
sources as well, e.g.
http://www.avsforum.com/t/1029603/ati-radeon-hd-4600-4800-series-support-7-1-channel-hdmi-audio#user_ATIHDMIDriver

It doesn't appear to work, though. Is it possible some of those early
cards had some other way of getting multichannel LPCM?
Looks like the above forum post directs people to use a "ATI HDMI Audio
Device" driver from Realtek for Vista/7...
(
http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PNid=24&PFid=24&Level=4&Conn=3&DownTypeID=3&GetDown=false
)

-- 
Anssi Hannula
