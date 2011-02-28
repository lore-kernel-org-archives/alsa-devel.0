From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: period_time in slave definition
Date: Mon, 28 Feb 2011 13:25:34 +0100
Message-ID: <4D6B943E.4060302@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A809103824
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 13:25:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id 33234A19C830B
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 13:25:34 +0100 (CET)
Received: from cable.insite.cz ([127.0.0.1])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EzxBJs2zG-J3 for <alsa-devel@alsa-project.org>;
	Mon, 28 Feb 2011 13:25:34 +0100 (CET)
Received: from [192.168.1.20] (sara.insite.cz [192.168.1.20])
	(Authenticated sender: pavel)
	by cable.insite.cz (Postfix) with ESMTPSA id 0F8BEA19C8303
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 13:25:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

According to
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html , my
.asoundrc contains:

pcm.test {
        type plug
        slave {
                pcm "hw:0"
                format "unchanged"
                channels "unchanged"
                rate "unchanged"
                period_size 1024
                buffer_size 4096
        }
}


While pcm, format, channels, and rate are accepted, the period and
buffer fields are refused:

ALSA lib pcm.c:6811:(snd_pcm_slave_conf) Unknown field period_time

I checked the source code and the keywords seem to be ok

pcm.c:
static const char *const names[SND_PCM_HW_PARAM_LAST_INTERVAL + 1] = {
	[SND_PCM_HW_PARAM_FORMAT] = "format",
	[SND_PCM_HW_PARAM_CHANNELS] = "channels",
	[SND_PCM_HW_PARAM_RATE] = "rate",
	[SND_PCM_HW_PARAM_PERIOD_TIME] = "period_time",
	[SND_PCM_HW_PARAM_PERIOD_SIZE] = "period_size",
	[SND_PCM_HW_PARAM_BUFFER_TIME] = "buffer_time",
	[SND_PCM_HW_PARAM_BUFFER_SIZE] = "buffer_size",
	[SND_PCM_HW_PARAM_PERIODS] = "periods"
};


Has any change been introduced recently which is not reflected on wiki
yet? Is there a way to specify "default" period and buffer parameters?

Thanks a lot,

Pavel.
