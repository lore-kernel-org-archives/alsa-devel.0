From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: share/smix pcm plugin [was [linux-audio-dev] Audio routing issues for
 linux..]
Date: Mon, 10 Jun 2002 17:31:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D04C64A.40CCBEA3@folkwang-hochschule.de>
References: <200206100536.g5A5agb25978@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-dev@music.columbia.edu, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

hi !

in reply to a posting by juan linietsky, Paul Davis wrote:
> =

[allowing multiple apps to play at the same time (esound-style) on
hardware that does not support multi-open]
> =

>  * ALSA already has the "share" PCM device type which allows
>      multiple access to the same underlying hardware. It hasn't
>      been tested very much, but it does basically work.

i think it does not do this. from the docs:

This plugin allows sharing of multiple channels with more clients. =

The access to each channel is exlusive (samples are not mixed together).
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
It means, if the channel zero is used with first client, the channel =

cannot be used with second one. =

If you are looking for a mixing plugin, use the smix plugin *unknown
reference!* . =

                                                           =

^^^^^^^^^^^^^^^^^^^^ =

it seems the share device as many people need it is not yet implemented.
i don't know how hard this is or what the problems are. alsa gurus ?

***

side question: if the alsa-lib provided "software multi-open" and
software mixing as a plugin that uses the hw: pcm device for output
(i.e. without further processing), would that increase latency compared
to direct hw: access ?


regards,

j=F6rn

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
