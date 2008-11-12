From: "christian pellegrin" <chripell@gmail.com>
Subject: Re: maximum tolerable sampling frequency difference
	for a driver
Date: Wed, 12 Nov 2008 18:36:49 +0100
Message-ID: <cabda6420811120936v9617445k273e07e3098fc43@mail.gmail.com>
References: <cabda6420811110817u42eafc74wfde36de113c98df1@mail.gmail.com>
	<491AF7D0.40806@ladisch.de> <20081112154607.GI8767@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 25DF81037F1
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 18:36:50 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so480768rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 09:36:49 -0800 (PST)
In-Reply-To: <20081112154607.GI8767@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 4:46 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Wed, Nov 12, 2008 at 04:35:44PM +0100, Clemens Ladisch wrote:
>
>> When an application requests a frequency that is not supported by the
>> device, it is the application that must decide whether the actual
>> frequency is acceptable.
>
> In theory.  In practice few applications have substantial tolerance for
> this and in many situations the cost of dealing with it (such as doing
> soft conversion) is worse than a small error.
>

I see, thank you both for the answer.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
