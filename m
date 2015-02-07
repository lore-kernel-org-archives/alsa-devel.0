From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: [Intel HDA][ALC3226] Too much white noise from
	microphone
Date: Sat, 7 Feb 2015 11:12:40 +0000
Message-ID: <CAKudYbPK9VH_qmX8Ov1ohPKzOPr=uEJCxTdmtEdA1mwQ_TEH7Q@mail.gmail.com>
References: <8841801.KiuVFG1hDJ@segfault>
	<54D4A9F9.6090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C9ED2604C2
 for <alsa-devel@alsa-project.org>; Sat,  7 Feb 2015 12:12:41 +0100 (CET)
Received: by iecrl12 with SMTP id rl12so7073203iec.0
 for <alsa-devel@alsa-project.org>; Sat, 07 Feb 2015 03:12:40 -0800 (PST)
In-Reply-To: <54D4A9F9.6090709@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 6, 2015 at 11:48 AM, Alexander E. Patrakov
<patrakov@gmail.com> wrote:
> http://www.alsa-project.org/main/index.php/HDA_Analyzer
Ah, i wasn't aware of this tool and I have a HDA in my laptop...

> If this doesn't help, just click around randomly. Maybe you'll find the
> magic checkbox that makes the noise go away and the voice stay :)
No luck yet, played with the internal mic, which is very noise and SNR
is much too high to be usable. Setting vref to 50 gives the best SNR,
still not usable though.

Changing the "digital" capture level in alsamixer changes the level of
the internal mic signal - is this expected? I looked for the "digital"
capture level control in HDAAnalyzer, but couldn't find it - vendor
defined?

Cheers, -Harry

-- 

http://www.openavproductions.com
