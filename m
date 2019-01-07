From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH ucm/conf: 0/5] Factor out rt5645 + rt5650
 shared UCM sequences
Date: Mon, 7 Jan 2019 11:32:48 +0100
Message-ID: <ffbdb8ad-9a65-2bbc-4152-7633693b3cde@perex.cz>
References: <20190106034715.21045-1-russell.parker7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D682526799D
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 11:32:50 +0100 (CET)
In-Reply-To: <20190106034715.21045-1-russell.parker7@gmail.com>
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
To: russell.parker7@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 6.1.2019 v 04:47 russell.parker7@gmail.com napsal(a):
> Hi,
> 
> When I submitted a patch to create a UCM config for chtrt5650 it was
> suggested that I also factor out command sequences that it shares with
> chtrt5645. The following patchset introduces a new component directory
> codecs/rt5645-common/ and refactors UCM profiles in:
> 
> - chtrt5645
> - chtrt5645-mono-speaker-analog-mic
> - chtrt5650
> - ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN
> - LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216
> 
> I compiled and tested playback with the rt5650 configs but I don't
> have the devices to test the other configurations. Suggestions and feedback
> are welcome, I'm not very familiar with UCM configuration so there may
> definitely be better approaches for some of these changes.

Thanks. I applied your changes to the alsa-lib's repo with only one
minor modification - I changed rt5645-common directory name to rt5645. I
don't see the reason to explicitly say that it's common code. All
configs in the codecs/ tree are common, don't they?

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
