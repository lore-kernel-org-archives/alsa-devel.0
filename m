From: Mark Hills <mark@pogo.org.uk>
Subject: Re: several messages
Date: Tue, 8 Sep 2009 23:56:44 +0100 (BST)
Message-ID: <alpine.BSO.2.00.0909082348000.13301@zrgural.vwaro.pbz>
References: <alpine.BSO.2.00.0909061445140.28864@zrgural.vwaro.pbz>
	<20090908213245.0f97cabc@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 2952A2434A
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 00:56:46 +0200 (CEST)
In-Reply-To: <20090908213245.0f97cabc@Jay>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giuliano Pochini <pochini@shiny.it>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 8 Sep 2009, Giuliano Pochini wrote:

> On Sun, 6 Sep 2009 15:16:57 +0100 (BST)
> Mark Hills <mark@pogo.org.uk> wrote:
>
>> I have an Echo Layla 3G in my workstation. It works for audio, but does
>> not recover from ACPI suspend to RAM.
>
> I does not recover because there is not suspend/resume support. I wrote
> almost complete support a lot of time ago which wasn't merged due to two
> unsolved issues. The resurrection procedure (actually it is a reinit from
> scratch) was very unreliable on my Gina24 for unknown reasons and there
> was an atomicity issue in the rawmidi interface.
> I can manage to provide you a patch for testing in a few days.

Thanks Giuliano and Takashi for the replies.

The reason for my quietness is I decided loading/unloading the module was 
a hack so I followed Takashi's documentation, aiming to implement some 
kind of suspend/resume.

However didn't have a great deal of luck; it's made especially hard with 
not having a separate serial console or way of viewing debug messages when 
the machine locks. It seemed that the amount of de-initialisation affects 
the ability to reinitialise the Layla 3G card from scratch. Then I ran out 
of time.

It would be great to see the patch, I'd be very happy to help with 
testing. Thanks for your work on this.

-- 
Mark
