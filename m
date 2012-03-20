From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
 protection mode
Date: Tue, 20 Mar 2012 14:07:52 -0400
Message-ID: <CA+7tXii62Z8NH7jMhi8XRONHd9c4E0HC7edUB-HB=8ckcE8q7Q@mail.gmail.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<20120320160154.GI3445@opensource.wolfsonmicro.com>
	<CANOLnOPjqbeEbSDUHokkGRUa7KwJ-+hAczWSmQ3LEccCh9-c7w@mail.gmail.com>
	<20120320170444.GA6938@opensource.wolfsonmicro.com>
	<CANOLnONkvk63ABDN_mX2g79EKMgfk0H71CRLaUmXSrwa55+C7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 83223243A8
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 19:07:54 +0100 (CET)
Received: by wgbed3 with SMTP id ed3so142395wgb.20
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 11:07:53 -0700 (PDT)
In-Reply-To: <CANOLnONkvk63ABDN_mX2g79EKMgfk0H71CRLaUmXSrwa55+C7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 20, 2012 at 1:27 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> On Tue, Mar 20, 2012 at 7:04 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Tue, Mar 20, 2012 at 06:15:34PM +0200, Grazvydas Ignotas wrote:
>>> On Tue, Mar 20, 2012 at 6:01 PM, Mark Brown
>>
>>> > though this should probably have the note about working around broken
>>> > applications from the cover letter in the changelog as with the
>>> > changelog alone it's really not apparent why we're doing this here as a
>>> > driver specific thing.
>>
>>> I wouldn't really call them broken, it's enough to set period size to
>>> 512 with smaller start_threshold (something like 50ms) to have
>>> problems, those parameters are perfectly valid for a program trying to
>>> achieve low latency.
>>
>> If they can't cope with the parameters they've set I'd call them broken,
>> they should've asked for more sensible parameters.

It sounds like the problem happens if an application sets
start_threshold to something less than the FIFO size.  E.g., set
start_threshold to 50ms, app writes 50 ms to stream, gets an instant
underrun when the sDMA quickly reads > 50 ms of audio as it fills the
FIFO.  Doesn't seem like the app is broken to expect that after
writing 50 ms of audio it has almost 50 ms to write more before an
underrun.
