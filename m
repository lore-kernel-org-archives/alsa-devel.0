From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: hdsp problem
Date: Tue, 13 Jan 2004 13:23:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040113132353.1f672adb.TimBlechmann@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

i've got a problem with my hammerfall dsp (multiface + cardbus) ...

it might be an alsa problem: i can load all modules and upload the
firmware with hdsploader ... and i can mix the inchannels to the
outchannels with hdspmixer ... 
but when i start a sound application (jack,oss layer, aplay) everything
i get is a distorted sound. i recorded this sound and it seems that
there is one block of audio data followed by one block of silence (have
a look at it at http://www.volny.cz/guitar_billy/hdsp.screenshot.png,
there might be some errors at the edges of the blocks because of the mp3
compression of the original soundfile, thanks to alex for putting it
online!)
then i start any sound application the sound that's routed from
the input is being distorted, too, (i suppose every second block is
cleared to zero samples)

i used several alsa version, several kernels (2.4, 2.6), changing the
pci latency doesn't change anything, either ...

if anyone has an idea, what might be the issue, i'd be interesting to
hear...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac



-- 
 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
