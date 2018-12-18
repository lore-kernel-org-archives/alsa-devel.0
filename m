From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Tue, 18 Dec 2018 12:39:09 +0200
Message-ID: <5a2103c5-194b-cb21-672e-d472e91825a8@gmail.com>
References: <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <20181217123703.GF13868@sirena.org.uk>
 <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
 <20181217141008.GA27909@sirena.org.uk>
 <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
 <20181217154043.GC27909@sirena.org.uk>
 <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
 <20181217165257.GD27909@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 749CB26782E
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 11:39:12 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id v13so15340215wrw.5
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 02:39:12 -0800 (PST)
In-Reply-To: <20181217165257.GD27909@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 12/17/18 6:52 PM, Mark Brown wrote:
> On Mon, Dec 17, 2018 at 06:23:43PM +0200, Dimitris Papavasiliou wrote:
>> I've already tried your suggestion, but unfortunately it doesn't
>> work in the general case, as it doesn't help when the hw_params
>> callback is called while the device is opened (but not playing).
> 
> The device being open shouldn't have any impact on the power state?

It's been a while since I tried it, but, as far as I recall, that was
the observed behavior (determined via printk statements in the CODEC's
set_bias_level callback).  To test potential fixes, I have a script
that opens the device and switches sampling rate between 44.1kHz and
48kHz every one second.  It popped almost every time.

(I've also tried variations of the script where a sample is played
every one second, again switching between the above sample rates and
where the device is closed an reopened at every switch.  The behavior
is mostly the same.)

If you're positive that the expected behavior should be different, I
could try it again, providing more details.

>>> Unfortunately none of this helps.  Although the chip is turned
>>> off without delay, it's turned off only while the device is
>>> closed.  As soon as the device is opened, it is turned on and
>>> kept on during all subsequent hw_params calls, where clock
>>> switching takes place.  The pops always get through.

> I would expect the stream to be closed and reopened by most applications
> in between reconfigurations like that, it certainly used to be the
> common pattern.

If by stream you mean the device, then perhaps they do.  As explained
above, I test using a script, instead of using applications, such as a
media player, as it's easier to reproduce the problem repeatedly at
will and under controlled conditions.  At any rate, a potential fix of
the problem, shouldn't depend on application behavior.
