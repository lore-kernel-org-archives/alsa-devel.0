From: "Emilio Federici" <emo_xine-mail@lycos.com>
Subject: Re: FM801 5.1 surround
Date: Mon, 19 Aug 2002 19:51:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <LGHIPIHNDOIBBBAA@mailcity.com>
Reply-To: emo_xine-mail@lycos.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailcity.com (fes2.mail.lycos.com [209.185.123.102])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id UAA26241
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 20:52:23 +0200
Content-Language: en
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 
--

On Mon, 19 Aug 2002 17:54:38  
 Takashi Iwai wrote:

>
>which ac97 chip on the card?  no relevant mixer elements?
>
>i guess the fm801 engine itself already supports 6 channels but the
>codec is not.
>
>
>Takashi
>

Hi Takashi, thanks for your immediate answer. I unplugged the card and found it has 2 ac97 chips:

SIGMATEL STAC9721T
WM XWM9704

This is the 'amixer scontrols' output:
[root@localhost root]# amixer scontrols
Simple mixer control 'Master',0
Simple mixer control 'Master Mono',0
Simple mixer control 'Master',1
Simple mixer control 'Master Mono',1
Simple mixer control '3D Control - Center',0
Simple mixer control '3D Control - Depth',0
Simple mixer control '3D Control - Switch',0
Simple mixer control '3D Control - Switch',1
Simple mixer control '3D Control Sigmatel - Depth',1
Simple mixer control 'PCM',0
Simple mixer control 'PCM',1
Simple mixer control 'Surround',0
Simple mixer control 'FM',0
Simple mixer control 'Wave',0
Simple mixer control 'Line',0
Simple mixer control 'Line',1
Simple mixer control 'CD',0
Simple mixer control 'CD',1
Simple mixer control 'Mic',0
Simple mixer control 'Mic Boost (+20dB)',0
Simple mixer control 'Mic Boost (+20dB)',1
Simple mixer control 'Mic',1
Simple mixer control 'Video',0
Simple mixer control 'Video',1
Simple mixer control 'Phone',0
Simple mixer control 'Phone',1
Simple mixer control 'I2S',0
Simple mixer control 'IEC958',0
Simple mixer control 'IEC958 Raw Data',0
Simple mixer control 'PC Speaker',0
Simple mixer control 'PC Speaker',1
Simple mixer control 'Aux',0
Simple mixer control 'Aux',1
Simple mixer control 'Capture',0
Simple mixer control 'Capture',1
Simple mixer control 'Mix',0
Simple mixer control 'Mix Mono',0
Simple mixer control 'Mix',1
Simple mixer control 'Mix Mono',1
Simple mixer control 'AC97 18-bit',0
Simple mixer control 'AC97 2ch->4ch Copy',0
Simple mixer control 'External Amplifier Power Down',0
Simple mixer control 'External Amplifier Power Down',1

I'm considering upgrading to a Sounblaster Audigy (for this among many other reasons) but I read that it has similar problems with 5.1 output, is that still true?

Thanks for your help
Bye!


__________________________________________________________
Outgrown your current e-mail service? Get a 25MB Inbox, POP3 Access,
No Ads and No Taglines with LYCOS MAIL PLUS.
http://login.mail.lycos.com/brandPage.shtml?pageId=plus


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
