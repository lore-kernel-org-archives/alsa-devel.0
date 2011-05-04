From: hong zhang <henryzhang62@yahoo.com>
Subject: trigger function is constantly called
Date: Wed, 4 May 2011 11:07:15 -0700 (PDT)
Message-ID: <544248.82118.qm@web161718.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm26.bullet.mail.bf1.yahoo.com (nm26.bullet.mail.bf1.yahoo.com
	[98.139.212.185])
	by alsa0.perex.cz (Postfix) with SMTP id 238E910382A
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 20:07:16 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

List,

My code in driver looks like:

static struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
	.startup	= davinci_mcasp_startup,
	.trigger	= davinci_mcasp_trigger,
	.hw_params	= davinci_mcasp_hw_params,
	.set_fmt	= davinci_mcasp_set_dai_fmt,

};

Trigger function, davinci_mcasp_trigger(), is called only once when do arecord or aplay from command line. Works perfect.

When combine both together and use ping pong buffers, if no (AEC) is introduced, sound is good. After adding (AEC- Acoustic Echo Canceler),
davinci_mcasp_trigger() is constantly called for start/close on playback side respectively and complain underrun (CPU is %90 usage).

Increase ping-pong buffers do not stop triggering.

Any help will be appreciated!

---henry
