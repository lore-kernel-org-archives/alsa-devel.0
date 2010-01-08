From: Oliver Stieber <oliverthered@gmail.com>
Subject: Re: alsa support for HDA ALC889A nVidia Corporation
	MCP55 High Definition Audio EVGA 122-CK-NF68
Date: Fri, 8 Jan 2010 17:41:45 +0000
Message-ID: <e15870681001080941k4a7ece4x5e50c8184714f4e5@mail.gmail.com>
References: <e15870681001071639v5507b254vee2d9892364dd6bf@mail.gmail.com>
	<4B475364.60904@gmail.com>
	<e15870681001080937t186f16afnb982cb931012b548@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id ACF0110384F
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 18:41:46 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so5198252eyh.16
	for <alsa-devel@alsa-project.org>; Fri, 08 Jan 2010 09:41:46 -0800 (PST)
In-Reply-To: <e15870681001080937t186f16afnb982cb931012b548@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

just quit x and tried mb3, no sound.
module snd-hda-intel did unload ok though (often the module is still showen
as used when it's not)

i wrote a little bash script to try every model listed in the source code,
and mb5 was the only one that workedish and i had lots of kernel mess along
the way.

On Jan 8, 2010 3:46 PM, "Justin P. Mattock" <justinmattock@gmail.com> wrote:

On 01/07/10 16:39, Oliver Stieber wrote: > > Hi, > > I'm having some issues,
(and think I've discove...
using model=mb3 gives no effect?

Justin P. Mattock
