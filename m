From: "Bob Copeland" <me@bobcopeland.com>
Subject: Re: Bugs on aspire one A150
Date: Mon, 10 Nov 2008 11:51:09 -0500
Message-ID: <b6c5339f0811100851t1fd9a180pfe24312081885467@mail.gmail.com>
References: <491506DB.1070000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754554AbYKJQvW@vger.kernel.org>
In-Reply-To: <491506DB.1070000@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, ath5k-devel@lists.ath5k.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 7, 2008 at 10:26 PM, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> ** 2 - wireless: not to mention the fact that ath5k wasn't installed by
> default in ubuntu...
> wireless more or less works, but kernel log is full of backtraces.

As you've seen, these should at least be gone now...

> Was able to connect to my WPA2 access point.
> Sometimes wireless fails completely, especially after suspend to ram.

Did you get noise calibration failures in dmesg at this point?  Felix posted
a patch recently that handles them better.

> Advanced features like monitor/injection work, but when I changed the card's
> mac address it stopped working.
> I also noticed that if I then start airodump, then wireless works with new
> mac.

> ** 4 - wireless led doesn't work.
> ath5k devs, can you fix this?

Currently all the LED code we have in there is for setting a particular gpio
for particular laptops (and they differ between models).  We only have quirks
for IBM and HP, none for Acer.  Also, the legacy-hal seems to have a different
strategy for 2425 chips.  I can try to hack up some code for you to test.

-- 
Bob Copeland %% www.bobcopeland.com
