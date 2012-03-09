From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Fri, 09 Mar 2012 18:14:13 +0000
Message-ID: <1331316853.3789.4.camel@odin>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
	<CAOZdJXUy-hCOEk6beBrjv16iknsMWTHc+AxSyw-L8-hLEXQYSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with SMTP id 6227A103B26
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 19:14:29 +0100 (CET)
Received: by mail-wi0-f175.google.com with SMTP id hn6so660892wib.10
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 10:14:15 -0800 (PST)
In-Reply-To: <CAOZdJXUy-hCOEk6beBrjv16iknsMWTHc+AxSyw-L8-hLEXQYSw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-03-09 at 17:26 +0000, Tabi Timur-B04825 wrote:
> On Tue, Mar 6, 2012 at 12:16 PM, Liam Girdwood <lrg@ti.com> wrote:
> > Currently not all DAPM widget IO ops are holding their component mutex
> > (codec or platform). Make sure this is now held for DAPM widget IO operations.
> >
> > Signed-off-by: Liam Girdwood <lrg@ti.com>
> 
> This patch breaks the P1022DS, which uses the WM8776 as a codec.  The
> MPC8610HPCD, which is identical to the P1022DS but uses the CS4270
> codec instead, works fine.
> 
> I'm guessing it's some kind of deadlock, because as soon as I start
> playback, the system halts.  Not even Ctrl-C works.
> 

Can you switch on the mutex debugging kernel config here.  I've just had
a quick look and the WM8776 and its not holding the codec mutex or
calling snd_soc_update_bits_locked() so it must deadlock via another
path.

Thanks

Liam
