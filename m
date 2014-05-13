From: James Le Cuirot <chewi@aura-online.co.uk>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Tue, 13 May 2014 22:10:56 +0100
Message-ID: <20140513221056.0637c51d@symphony.aura-online.co.uk>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <loom.20131122T215246-90@post.gmane.org> <529004F8.7070801@iki.fi>
 <20131123154009.6c8c6e97@symphony.aura-online.co.uk>
 <5290CD7C.7020907@iki.fi>
 <20131124145737.22056256@symphony.aura-online.co.uk>
 <52934E97.9060701@iki.fi> <20131125143228.55c94550@red>
 <52936537.8020506@iki.fi>
 <20140513130126.1755fa16@red.yakaraplc.local>
 <53720FC3.7000608@iki.fi>
 <20140513171617.4d303844@red.yakaraplc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id F3FA126170F
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 23:11:03 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 80C1E21713
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 17:10:58 -0400 (EDT)
In-Reply-To: <20140513171617.4d303844@red.yakaraplc.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Le Cuirot <chewi@aura-online.co.uk>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 13 May 2014 17:16:17 +0100
James Le Cuirot <chewi@aura-online.co.uk> wrote:

> On Tue, 13 May 2014 15:27:47 +0300
> Anssi Hannula <anssi.hannula@iki.fi> wrote:
> 
> > Unfortunately I've been told that HD 4xxx cards and older do not
> > support multichannel playback, which I didn't know at the time (and
> > I had forgotten your case, hence I didn't get back to you - sorry
> > about that).
> 
> Thank you for the quick reply. I'm not sure whether that's strictly
> true. Wikipedia (though not always correct, I grant you) states that:
> 
> "The RV770 series GPU also supports xvYCC color space output and 7.1
> surround sound output (LPCM, AC3, DTS) over HDMI."
> 
> http://en.wikipedia.org/wiki/Radeon_HD_4000_Series#Multimedia_features
> 
> The HD 4670 has the RV730XT chip. It isn't clear in the above
> statement whether it is referring to the higher models in the range
> or the range as a whole, given that the RV770 is the foundation chip.
> Based on my experiences and what you have heard, it's probably the
> former. This news piece at AnandTech also seems to back it up.
> 
> "All of AMD's Radeon HD graphics cards have shipped with their own
> audio codec, but the Radeon HD 4800 series of cards finally adds
> support for 8-channel LPCM output over HDMI."
> 
> http://www.anandtech.com/show/2556
> 
> Looks like a new card for me then. Thanks for your help.

Aaaand after all that, I dig out the box for the old card to get ready
to sell it and what do I see printed on the front? 7.1 Channel Sound!
The box looks almost identical to this one:

http://www.overclockers.ua/video/ati-radeon-hd4670-ddr4/01-ati-radeon-hd4670-sapphire.jpg

This is very confusing. Any thoughts?

Regards,
James
