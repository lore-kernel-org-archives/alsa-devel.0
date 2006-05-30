From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
Subject: DMIX and alsa plugins (dmix plugin can be only
	connected to hw plugin)
Date: Tue, 30 May 2006 12:29:25 +0200
Message-ID: <447C1E85.3050505@palmsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,


I'm trying to use dmix with bluetooth-alsa in order to get sound mixing =

on bluetooth headset via a2dp.

I use dmix like this in my .asoundrc :

pcm.dsp0 {
    type dmix
    ipc_key 1456
    slave.pcm "hpheadphone"
}

pcm.hpheadphone {
        type a2dp
        bdaddr "00:0D:44:2A:17:C7"
}

I get the following error :

ALSA lib pcm_dmix.c:807:(snd_pcm_dmix_open) dmix plugin can be only =

connected to hw plugin

What can I do? However, my a2dp plugin seems to start correctly its =

initialisation!

Is there a way to fake a hw plugin? Can I force dmix to work with this =

plugin?

Any help is welcome, thanks,


Fr=E9d=E9ric
