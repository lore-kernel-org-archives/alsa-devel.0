From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: why snd_soc_suspend is not called
Date: Thu, 21 Jun 2012 10:47:12 +0800
Message-ID: <CAMj5BkgbmdALET_hiHL1LNs7v-+9RyEQPgg1EBzyadt6rZ+EJg@mail.gmail.com>
References: <CAMj5BkgV9odU+1VwhXx5w0Y8pPdHg25tHWNMX-5ecG_aL+r+cw@mail.gmail.com>
	<20120619093000.GA3974@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120619093000.GA3974@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Qiao Zhou <zhouqiao@marvell.com>, alsa-devel@vger.kernel.org, Leo Yan <leoy@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 19, 2012 at 5:30 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jun 19, 2012 at 01:12:05PM +0800, zhangfei gao wrote:
>
>> In fact, even soc_probe is not called since no soc-audio device.
>
> This is only called for soc-audio, if it were called otherwise it would
> be abug.
>
>> When running, system recommend using snd_soc_register_card instead.
>> After doing such modification, the audio could work.
>> But strangely snd_soc_suspend is not called, as well as soc-probe.
>> So cpu_dai->driver->suspend will no be called accordingly.
>
>> If manually add "soc-audio" in arch/, the soc-probe can be called.
>> But snd_soc_suspend still fail to be called.
>
>> Could you give me some suggestion?
>
> There is probably a bug in your code. =A0At a guess you've not set up the
> pm ops for your card.

Thanks Mark.
Using snd_soc_register_card, pm ops of cpu driver has to be provided
instead of dai driver as before.
However, SNDRV_PCM_TRIGGER_SUSPEND/RESUME can not be called.
SNDRV_PCM_TRIGGER_START/SNDRV_PCM_TRIGGER_STOP will be called in suspend/re=
sume.
Is it right?

Thanks
