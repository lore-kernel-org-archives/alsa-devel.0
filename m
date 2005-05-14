From: rong wang <rhong_wang@yahoo.com>
Subject: Several questions about digital mixing /plugin/sound effect
Date: Fri, 13 May 2005 21:10:55 -0700 (PDT)
Message-ID: <20050514041056.74619.qmail@web31702.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

1. if we have several audio streams needed to be mixed
before sending to CODEC, Should we
   have to use server such as Jacked to do the mixing
work? From document, Jacked is majorly used for data
streaming from one application to another application,
if I don't have such need, only for digital mixing,
Could I avoid to use Jacked such kind of audio server
for digital mixing purpose? For Jack server, how many
applications support and use Jacked?
>From searching on the web, it seems not a lot.
2.  Is the alsa-lib  statically linked to audio
application? Or the library is dynamically linked? 
3. Where the software sound effect processing (Chorus,
echo cancellation etc) in the ALSA?
4. Is there any document to introduce ALSA plugin (how
to expand it to include our own plugin, how it works
etc)?
5. If I have one application tried to playback
different format sound, MP3, AAC etc, if I have my own
MP3, AAC decoder, Is there anyway application can
unplug one SW CODEC and load another plugin depends on
File format on the fly?
6. If on my machine, I cannot run float data type,
only integer, Could I still use Jacked, according to
   doc, Jacked is 32 bit float? Is there any other
better choice? 
7. If I don't need sequencer etc stuff, How could I
remove the sequencer from lib and rebuild the lib?
Not sure I asked the right question, I am totally new
here.



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
