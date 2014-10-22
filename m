From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Help with wm8731 support for the Utilite (imx6q)
Date: Wed, 22 Oct 2014 14:02:29 -0200
Message-ID: <CAOMZO5DDZZiu0w6mD0T-SDXdYWOdjimwruAp2LivskeiuTii9w@mail.gmail.com>
References: <CAB-pspc5KZ0sTB-7uxjBq+PEFxFdAPO5NAXof_+uwQBJ_JCejg@mail.gmail.com>
 <CAOMZO5C-EG+beiK1M10vX0Xhg4avYLExxG7MZOQq8gM6gRnANw@mail.gmail.com>
 <CAB-pspcNOuW=JN9_avEvyPFUvTfs99PB=ah43YdqMC65mZ8psQ@mail.gmail.com>
 <CAB-pspei1a3TbuFGBT-kupEWU5UY10kQoTtiV895WTi-j+-dzQ@mail.gmail.com>
 <CAOMZO5AVr0xJjf9JjYNuXG-jJC3ft84+fO-5ToSieP9NFP=-+g@mail.gmail.com>
 <CAOMZO5CU+Y8cGJsn4O1ccFZUSjLM1iH3QN2fAv4UyaLMk5yAEg@mail.gmail.com>
 <CAB-pspdvzFX-KjYSC3z3xoDMPvq4g3iFhBG76Y=DGy=YBf5dow@mail.gmail.com>
 <54464C32.8020100@compulab.co.il>
 <CAB-pspcaMh9DL8bND1kSmphZfMYNOvPS_CYZ8UYZ2EZuVjjksg@mail.gmail.com>
 <CAOMZO5A=RSodq=JmjrjHTJSg9QaEx42uu7vAbON=Jk5-Gmiv9Q@mail.gmail.com>
 <CAB-pspcmxQAzR=jX1_fp06UUgNbC_LXFDN4g6RnOn6vTTvJjTw@mail.gmail.com>
 <CAB-pspcZ8bhLMPDS2NbDOEugfzO+TZfOnA_h05pvkU5ZPv6qVQ@mail.gmail.com>
 <544764F4.8070904@compulab.co.il>
 <CAB-pspeg-sP4Ebk+SF8WAxOJwobEk_rgeYnPr=thK2j7O638QA@mail.gmail.com>
 <CAOMZO5A_K9MV+Y5cBWcoLDOCnBH9VX7tkOmBTQh43UdqAtLzGA@mail.gmail.com>
 <CAB-pspcoyzQNWhGf_1ex86f2E9spotPGVJzDR0i2=98eMXfxiw@mail.gmail.com>
 <CAOMZO5B95cBvHOyOMzSqYQ+LedPj4OsWc=opjEzuRA7Tgkv97w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com
 [209.85.217.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A441265200
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 18:02:29 +0200 (CEST)
Received: by mail-lb0-f174.google.com with SMTP id p9so3100548lbv.19
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 09:02:29 -0700 (PDT)
In-Reply-To: <CAOMZO5B95cBvHOyOMzSqYQ+LedPj4OsWc=opjEzuRA7Tgkv97w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Bennett <jbscience87@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Aaron Kling <webgeek1234@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Valentin Raevsky <valentin@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 22, 2014 at 12:29 PM, Fabio Estevam <festevam@gmail.com> wrote:

> What about changing this part to?

Forgot that you use ssi as master and codec as slave, so something
like this maybe:

       sound {
                compatible = "simple-audio-card";
                simple-audio-card,model = "wm8731-audio";
                simple-audio-card,format = "i2s";
                simple-audio-card,bitclock-master = <&dailink0_master>;
                simple-audio-card,frame-master = <&dailink0_master>;
                simple-audio-card,audio-routing =
                        "Line Out", "LOUT",
                        "Line Out", "ROUT",
                        "LLINEIN","Line In",
                        "RLINEIN","Line In";

                dailink0_master: simple-audio-card,cpu {
                        sound-dai = <&ssi2>;
                        clocks = <&clks IMX6QDL_CLK_CKO>;
                };

                simple-audio-card,codec {
                        sound-dai = <&codec>;

                };
        };
