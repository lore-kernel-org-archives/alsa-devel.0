From: Tyson Whitehead <twhitehe@uwo.ca>
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Tue, 01 Apr 2008 14:07:35 -0400
Message-ID: <47F279E7.60801@uwo.ca>
References: <20080314233357.5223BDBA2@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-alpha-owner@vger.kernel.org>
In-reply-to: <20080314233357.5223BDBA2@gherkin.frus.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Bob Tracy <rct@frus.com>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Michael Cree <mcree@orcon.net.nz>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Krzysztof Helt <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

Bob Tracy wrote:
> rct wrote:
>> Rene Herman wrote:
>>> Okay, and applying the attached just makes your sound completely dead in the 
>>> water?
>>> (patch to remove es1888_init from a Miata build omitted)
>> I'll try a build with the old OSS "sb" driver, and if that works ok, we
>> may be able to do away with es1888_init() on the Miata.  Tyson -- I
>> think you have a Miata if I'm remembering correctly: can you confirm
>> these observations?
> 
> Quick followup: OSS "sb" driver works fine without es1888_init().
> 

Okay.  I finally got everything tested on my Miata.  Unless I missed 
something, the es1888_init routine only gets compiled in with 
CONFIG_ALPHA_MIATA.  As I've been using the debian generic kernel (i.e., 
CONFIG_ALPHA_GENERIC), I have never relied on this routine for anything.

I did discover, however, when I compiled my own kernel (2.6.25-rc5) with 
CONFIG_ALPHA_MIATA, things stopped working.  Specifically, I no longer 
got any interupts (with or without the es1888_init patch and with or 
without the alternative es188xx interupt patch) associated with either 
the builtin sound card (es1888) or the IDE controller (CMD646).

With CONFIG_ALPHA_GENERIC I only get one interupt with the es18xx driver 
unless I applied to "alternative interupt" handling code.  Further, 
sometime between 2.6.14 and 2.6.16, mpg321 (using the alsa driver) 
started generating "Bad page state in process 'mpg321' ... Trying to fix 
it up, but a reboot is needed" kernel messages.

The machine would continue to operate okay though.  However, somewhere 
between 2.6.16 and 2.6.24, it also started crashing very shortly 
thereafter, giving the following backtrace: free_pages_check, 
free_hot_cold_pages, put_pages, free_page_and_swap_cache, unmap_cmas, 
unmap_region, default_wake_function, do_munmap, sys_munmap, entSys.

Hope this helps.

Cheers!  -Tyson

