From: Conrad Parker <conrad@vergenet.net>
Subject: Sweep 0.8.2 Released: ALSA 0.9 support, i18n updates
Date: Wed, 30 Apr 2003 21:42:39 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030430114239.GA12439@vergenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: sweep-announce@lists.sourceforge.net, linux-audio-announce@music.columbia.edu
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Wed Apr 30 2003 -- Sweep 0.8.2 Released
=======================================

Sweep is an audio editor and live playback tool for GNU/Linux, BSD and
compatible systems. It supports many music and voice formats including
WAV, AIFF, Ogg Vorbis, Speex and MP3, with multichannel editing and
LADSPA effects plugins. Inside lives a pesky little virtual stylus called
Scrubby who enjoys mixing around in your files.

This release is available as a source tarball at:

    http://prdownloads.sourceforge.net/sweep/sweep-0.8.2.tar.gz?download


Latest News
-----------

This release contains support for ALSA 0.9; this is configurable and could
do with widespread testing.
                                                                               
To build with ALSA support, simply configure with:
                                                                               
        ./configure --enable-alsa
                                                                               
Note that doing this will build a binary which will work with ALSA only,
and not attempt to use OSS. In future this will be replaced with plugins
for different pcm i/o methods, which should ease binary distribution.
                                                                               
                                                                               
Internationalization (i18n) improvements:
                                                                               
        * a complete audit of untranslateable strings, including
        mis-configured source files and unmarked strings, by
        Silvia Pfeiffer.
                                                                               
        * a new Greek translation by Dokianakis Fanis
        * a new Russian translation by Alexandre Prokoudine
        * an updated Italian translation by Yuri Bongiorno
        * an updated German translation by Silvia Pfeiffer
                                                                               
There is a new mailing list: sweep-i18n. List information is at
http://lists.sourceforge.net/lists/listinfo/sweep-i18n
                                                                               
                                                                               
Additional changes include:
                                                                               
        * added VBR without DTX option for Speex 1.0 speech encoding
        * improved accuracy of sliders in processing dialogs
                                                                               
                                                                               
Events:
                                                                               
Conrad will presenting and demoing Sweep at the following upcoming events:
                                                                               
  Jul 10-13       LinuxTag 2003 (Karlsruhe, Germany)
                  Conference and Linux Audio Dev (LAD) exhibition booth
                  http://www.linuxtag.org/
                                                                               
  Jul 31 - Aug 3  UKUUG Linux Developers Conference (Edinburgh, Scotland)
                  http://www.ukuug.org/events/linux2003/
                                                                               
Plus, the Call for Participation for the Linux Audio Mini-Conf @ LCA2004
(Jan 12-13 2004, Adelaide, South Australia) is announced:
                                                                               
    http://www.metadecks.org/events/lca2004/
                                                                               

Further information
-------------------

Screenshots:

    http://www.metadecks.org/software/sweep/screenshots/

Some interesting audio recordings of Scrubby are at:

    http://www.metadecks.org/software/sweep/demos.html

Sweep is designed to be intuitive and to give you full control. It includes
almost everything you would expect in a sample editor, and then some:

	* precise, vinyl like scrubbing
	* looped, reverse, and pitch-controlled playback
	* playback mixing of unlimited independent tracks
	* looped and reverse recording
	* internationalisation
	* multichannel and 32 bit floating point PCM file support
	* support for Ogg Vorbis, MP3 and Speex compressed audio files
	* sample rate conversion and channel operations
	* LADSPA 1.1 effects support
	* multiple views, discontinuous selections
	* easy keybindings, mouse wheel zooming
	* unlimited undo/redo with fully revertible edit history
	* multithreaded background processing
	* shaded peak/mean waveform rendering, multiple colour schemes

Sweep is Free Software, available under the GNU General Public License.

More information is available at:

    http://www.metadecks.org/software/sweep/

Thanks to Pixar Animation Studios and CSIRO Australia for supporting the
development of this project.

enjoy :)

Conrad.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
