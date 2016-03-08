From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Testing SAI with mainline
Date: Mon, 7 Mar 2016 23:57:28 -0300
Message-ID: <CAOMZO5BE6BitKccaYpP5sUf2zfAemUunFqht+Ke_4_Rykva41w@mail.gmail.com>
References: <CAOMZO5DnC7NGd1+QPzeaVQ0GMY_yxq3KZBQSAOoj+QKQ8W+HfQ@mail.gmail.com>
 <20160307205109.GA10095@Asurada-Nvidia>
 <CAOMZO5BLyouO6VbkR=aUwygSfizd41naR5j92zkmcSKZrKMURQ@mail.gmail.com>
 <AM3PR04MB14127296AFC982D9E19226B09AB20@AM3PR04MB1412.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
 [209.85.213.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C763264F3F
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 03:57:29 +0100 (CET)
Received: by mail-ig0-f182.google.com with SMTP id z8so7465541ige.0
 for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2016 18:57:29 -0800 (PST)
In-Reply-To: <AM3PR04MB14127296AFC982D9E19226B09AB20@AM3PR04MB1412.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@nxp.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Zidan,

On Mon, Mar 7, 2016 at 11:49 PM, Zidan Wang <zidan.wang@nxp.com> wrote:

> You should change the sdma peripheral types of SAI to 24.

Thanks! That did the trick.

I have also tried with 25, which is what NXP BSP uses, but it did not work.

Care to explain why 24 is needed here?

I will prepare some patches and submit them tomorrow so that we have
SAI working on this board.

Thanks for your help
