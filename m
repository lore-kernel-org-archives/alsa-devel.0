From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: Re: help for a levelmeter
Date: Wed, 16 Oct 2002 00:40:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021015224039.59921.qmail@web12207.mail.yahoo.com>
References: <3DAC8580.7010004@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DAC8580.7010004@club-internet.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Laurent Georget <lgeorget2@club-internet.fr>
Cc: Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Laurent Georget: 
>   Hello,
> 
> I 'd like to make a levelmeter program which would
> display sound card
> input/output
> while the audio device is opened by another program.
> I tried to use copy
> plugin  , but now (since 0.9.0rc3 ) the
> "snd_pcm_copy_open" give a "implicit
> declaration of function"
hmm, it is still declared in
alsa-lib/include/pcm_plugin.h ...?
> message . (Anyway, i don't know if using this plugin
> was correct for
> that purpose)
> 
> So, would you know a way to read audio data going to
> (or coming from)
> the device , when it is opened by another program ?
> 
> Thanks for any help!
> 
> Laurent

(there is a jack meter client @
http://plugin.org.uk/meterbridge/)


regards, karsten


__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
