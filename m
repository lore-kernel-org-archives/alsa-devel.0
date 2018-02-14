From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: wm9713: Use empty struct
	initializer
Date: Wed, 14 Feb 2018 15:19:25 -0200
Message-ID: <CAOMZO5BmUD_+MZJ9s_mXvgurDAi6ZrM2eit2Z6hJCoGf476L9Q@mail.gmail.com>
References: <1518622745-12162-1-git-send-email-festevam@gmail.com>
 <1518622745-12162-2-git-send-email-festevam@gmail.com>
 <938aa54c-c599-9efc-e78f-4e72db08199e@opensource.cirrus.com>
 <CAOMZO5BS9oiDPT3oEK7ROhetJcHmfWL+XGZsY9ncMJsB9Qcbww@mail.gmail.com>
 <52f37612-1e70-33d7-f4c9-e1221e6667fd@opensource.cirrus.com>
 <CAOMZO5ASMYzPg4j2LfHqmVZ6VsE6094N2_rfkquoME2vj9Ab7w@mail.gmail.com>
 <86924c5f-9f62-8d38-3a24-86e40b8cb843@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 09392267B6D
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 18:19:26 +0100 (CET)
Received: by mail-oi0-f65.google.com with SMTP id b3so17042866oib.11
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 09:19:26 -0800 (PST)
In-Reply-To: <86924c5f-9f62-8d38-3a24-86e40b8cb843@opensource.cirrus.com>
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

On Wed, Feb 14, 2018 at 3:15 PM, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> I gather that, so I'd have liked to your commit message to have said that.
> But what you actually said was
>
> "{ 0 } only clears the first member of the structure."
>
> which is a very different message.

Got it. Maybe I should have written like this instead:

"{ 0 } only clears explicitly the first member of the structure."

Thanks for the feedback.
