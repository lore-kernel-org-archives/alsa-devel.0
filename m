From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: wm9713: Use empty struct
	initializer
Date: Wed, 14 Feb 2018 14:49:01 -0200
Message-ID: <CAOMZO5BS9oiDPT3oEK7ROhetJcHmfWL+XGZsY9ncMJsB9Qcbww@mail.gmail.com>
References: <1518622745-12162-1-git-send-email-festevam@gmail.com>
 <1518622745-12162-2-git-send-email-festevam@gmail.com>
 <938aa54c-c599-9efc-e78f-4e72db08199e@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f196.google.com (mail-ot0-f196.google.com
 [74.125.82.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 80984266F0D
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 17:49:03 +0100 (CET)
Received: by mail-ot0-f196.google.com with SMTP id f18so20925038otf.6
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 08:49:03 -0800 (PST)
In-Reply-To: <938aa54c-c599-9efc-e78f-4e72db08199e@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 14, 2018 at 2:41 PM, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> This is the actual problem you are trying to fix? The comment about
> { 0 } only clearing the first member is probably bogus, your actual
> problem is that it should have been { NULL } ?

Changing to { NULL } fixes the sparse warning, but that would be a
fragile fix because it relies on the order of the struct members.

If someday the struct changes in a way so that the first member is no
longer a pointer, then we will have issues again.

Using {} is more error prone.
