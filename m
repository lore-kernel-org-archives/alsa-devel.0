From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: why snd_soc_suspend is not called
Date: Tue, 19 Jun 2012 13:12:05 +0800
Message-ID: <CAMj5BkgV9odU+1VwhXx5w0Y8pPdHg25tHWNMX-5ecG_aL+r+cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi, Mark

Excuse me, I am confused about snd_soc_suspend.

When realizing cpu_dai->driver->suspend, we found snd_soc_suspend is not called.
In fact, even soc_probe is not called since no soc-audio device.

We manually alloc soc-audio deivce before in platfrom.c.
dev = platform_device_alloc("soc-audio", -1);
platform_set_drvdata(device, &snd_soc_card);
platform_device_add(dev);

When running, system recommend using snd_soc_register_card instead.
After doing such modification, the audio could work.
But strangely snd_soc_suspend is not called, as well as soc-probe.
So cpu_dai->driver->suspend will no be called accordingly.

If manually add "soc-audio" in arch/, the soc-probe can be called.
But snd_soc_suspend still fail to be called.

Could you give me some suggestion?

Thanks a lot.
