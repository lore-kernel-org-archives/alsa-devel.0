From: James Pearson <james-p@moving-picture.com>
Subject: Help with Creative's X-Fi drivers
Date: Fri, 28 Nov 2008 17:17:58 +0000
Message-ID: <493027C6.3090905@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 8742C1037E3
	for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2008 18:17:59 +0100 (CET)
Received: from minion.mpc.local ([172.16.11.112] helo=moving-picture.com)
	by moving-picture.com with esmtp (Exim 4.43) id 1L66yc-0007bc-Va
	for alsa-devel@alsa-project.org; Fri, 28 Nov 2008 17:17:59 +0000
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

I know the ALSA team don't support Creative's X-Fi drivers, but maybe 
someone could help with this issue:

I've managed to 'backport' Creative's recently GPL'd drivers to run on a 
CentOS4 kernel with ALSA 1.0.15 - the changes to the code were minor, 
but one thing I'm not sure about is, in ctpcm.c it has:

static int ct_pcm_timer_stop(struct ct_atc_pcm *apcm)
{
         unsigned long flags;

         CTDPF("%s is called\n", __func__);

         spin_lock_irqsave(&apcm->timer_lock, flags);
         apcm->stop_timer = 1;
         del_timer(&apcm->timer);
         spin_unlock_irqrestore(&apcm->timer_lock, flags);

         try_to_del_timer_sync(&apcm->timer);

         return 0;
}


The CentOS4/RHEL4 2.6.9 kernel doesn't have try_to_del_timer_sync() - 
so, should I replace it with del_timer() or del_timer_sync() ?

I'm currently using del_timer_sync() - and the driver works (I get sound 
out the head phone jack) - is this OK?

Thanks

James Pearson
