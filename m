From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
Date: Wed, 15 Apr 2009 00:48:08 +0200
Message-ID: <m2prfe26on.fsf@igel.home>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
	<1239724227.24771.9.camel@johannes.local>
	<1239730915.24771.12.camel@johannes.local>
	<20090414214949.736597d9@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <20090414214949.736597d9@hyperion.delvare> (Jean Delvare's
	message of "Tue, 14 Apr 2009 21:49:49 +0200")
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>, Benjamin@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jean Delvare <khali@linux-fr.org> writes:

> Hi Johannes,
>
> On Tue, 14 Apr 2009 19:41:55 +0200, Johannes Berg wrote:
>> Alright, with the patch Andreas pointed out it loads, but segfaults, as
>> below. Works fine without your patch.
>
> Thanks for the quick test and sorry that it didn't work. I'll take a
> look at the trace below and try to figure out what went wrong.
>
> Did you remove the 2 MODULE_DEVICE_TABLE from my patch? If you didn't,
> please pick the latest version of my patch which doesn't have them:
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/sound-aoa-codecs-convert-to-new-style.patch
> I don't think they are the reason of the crash, but who knows...

I tried with a tas-based iBook, and it works fine here.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
