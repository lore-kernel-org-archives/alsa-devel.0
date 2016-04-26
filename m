From: Conrad Kostecki <ck@conrad-kostecki.de>
Subject: Re: [PATCH] ALSA: intel_hda - Add dock support for
 ThinkPad X260
Date: Tue, 26 Apr 2016 12:12:39 +0200 (CEST)
Message-ID: <1430210497.4896.1461665559873@office.mailbox.org>
References: <em7d1d6a23-64ae-4940-a3db-c26ad0f13c6b@valkyrie>
 <s5hbn4w7pjs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.mailbox.org (mx2.mailbox.org [80.241.60.215])
 by alsa0.perex.cz (Postfix) with ESMTP id D4E812606C7
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 12:12:44 +0200 (CEST)
In-Reply-To: <s5hbn4w7pjs.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Takashi Iwai <tiwai@suse.de> hat am 26. April 2016 um 10:16 geschrieben:
> 
> 
> On Sun, 24 Apr 2016 03:48:21 +0200,
> Conrad Kostecki wrote:
> > 
> > Hi!
> > My shiny new ThinkPad X260 is the same way affected, as older ThinkPad 
> > (X*40, X*50) generations.
> > That means, I am unable to get sound output, when I am using the Lenovo 
> > CES 2013 docking station series (basic, pro, ultra).
> > 
> > It can be fixed the same way, as it was already done for X240 and X250, 
> > as the X260 uses the same docking connector.
> > I am attaching my patch, which works for me.
> 
> Thanks, applied now with a minor modification (adding the entry at the
> right place; it's sorted in the order of SSID).

Thank you! :) Will be this also included in 4.6?
