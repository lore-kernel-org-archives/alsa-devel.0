From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/3 v2] ASoC: ak4104: add regulator
	consumer support
Date: Fri, 28 Mar 2014 12:27:14 +0100
Message-ID: <53355C92.3000105@gmail.com>
References: <1395952936-10670-1-git-send-email-zonque@gmail.com>
 <1395952936-10670-2-git-send-email-zonque@gmail.com>
 <20140328112345.GZ30768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 52D76261A88
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 12:27:16 +0100 (CET)
Received: by mail-bk0-f43.google.com with SMTP id v15so892576bkz.2
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 04:27:16 -0700 (PDT)
In-Reply-To: <20140328112345.GZ30768@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/28/2014 12:23 PM, Mark Brown wrote:
> On Thu, Mar 27, 2014 at 09:42:15PM +0100, Daniel Mack wrote:
>> The AK4104 has only one power supply, called VDD. Enable it as long as
>> the codec is in use.
> 
> This should update the DT binding too.  Also it seems we still have a
> machine driver for Raumfeld using this which doesn't set full
> constraints and isn't being updated here so would be broken as far as I
> can tell.

Yeah, I noticed this one is unfortunately broken since a while already
due to other changes in ASoC. I'm working on fixing this in parallel,
but it's legacy hardware which get less attention than it should. I'll
fix up the constraints along with that.

Want me to resend with a DT bindings fix, or can we do that in 2nd step?


Daniel
