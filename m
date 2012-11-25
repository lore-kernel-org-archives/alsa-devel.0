From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [2.6.32.y] Re: [regression] no sound from Fujitsu Pi laptop
 unless headphones plugged in
Date: Sun, 25 Nov 2012 12:28:33 -0800
Message-ID: <20121125202833.GC24024@elie.Belkin>
References: <1286612714.8879.5.camel@pink>
 <20120101091142.GA4927@elie.hsd1.il.comcast.net>
 <20120101091324.GB4927@elie.hsd1.il.comcast.net>
 <20120216005618.GA29853@burratino>
 <20121125093136.GA21119@elie.Belkin>
 <20121125105158.GD18311@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121125105158.GD18311@1wt.eu>
Sender: stable-owner@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jose Manuel Castroagudin <j@chav.es>, Rafael Varela Pet <rpet@mundo-r.com>
List-Id: alsa-devel@alsa-project.org

Willy Tarreau wrote:
> On Sun, Nov 25, 2012 at 01:31:36AM -0800, Jonathan Nieder wrote:

>> Please consider
>>
>>   cfc9b06f0bef ALSA: hda - Add a pin-fix for FSC Amilo Pi1505
>>
>> for application to the 2.6.32.y tree.  Without this patch, the Amilo
>> Pi 1505's internal speaker is silent unless a jack is plugged into its
>> headphone jack.
>
> OK, queued now.

That was fast. :)  Thanks for looking it over.
