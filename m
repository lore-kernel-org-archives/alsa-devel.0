From: Timur Tabi <timur@freescale.com>
Subject: Re: Will ALSA ever call _prepare or _hw_params while
 it's	playing?
Date: Wed, 21 May 2008 10:56:50 -0500
Message-ID: <48344642.3050707@freescale.com>
References: <4834438A.4060702@freescale.com>
	<48344582.8020601@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <48344582.8020601@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@alsa-project.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Timur Tabi wrote:
>> I have an ASoC driver with a _hw_params, _prepare, and _trigger functions.  I've
>> recently discovered that I need to keep one of my devices disabled until
>> playback starts.
>>
>> So I would like to know if ALSA will ever call _hw_params, _prepare, or _trigger
>> if playback or capture is currently in process, or will ALSA first call the
>> _trigger to stop/pause the driver.
> 
> While a stream is running (after trigger with START), ALSA will only
> call the pointer or the trigger (STOP/PAUSE/SUSPEND) callbacks.

That's good.

> Different streams are not synchronized in any way.  (This also applies to
> the playback/capture streams of one card.)

Ah, I hadn't thought about that.  If I'm doing simultaneous capture and playback
through the same device, then I can't guarantee that it's disabled.  Argh.

Thanks.

-- 
Timur Tabi
Linux kernel developer at Freescale
