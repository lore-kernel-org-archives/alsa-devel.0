From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: On mixer controls naming
Date: Mon, 13 Jan 2014 12:12:40 +0100
Message-ID: <52D3CA28.3070500@ladisch.de>
References: <CAM6_cxyGVC+Tzt=6AM=LXn2Eqt48AK4JMSJkfbR07pPgPwBtcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 76E552608B7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 12:12:43 +0100 (CET)
In-Reply-To: <CAM6_cxyGVC+Tzt=6AM=LXn2Eqt48AK4JMSJkfbR07pPgPwBtcA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "R. Lemos" <rslemos@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

R. Lemos wrote:
> The other control I've named "Tone Control - Bass", as indicated in
> writing-an-alsa-driver.pdf. But alsamixer shows it under both
> "Playback" and "Capture" views.
>
> How can I restrict this latter control to just playback?

For a control to be classified as a playback control, its name must
have one of the suffixes " Playback Enum", " Playback Switch",
" Playback Route", or " Playback Volume".


Regards,
Clemens
