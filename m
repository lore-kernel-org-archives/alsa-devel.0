From: Benny Sjostrand <gorm@cucumelo.org>
Subject: non-destructive aproach for Built-In effects
Date: Fri, 17 Jan 2003 22:55:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E287BE0.4060905@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

Now I got a new non-destructive aproach in mind, implementing exactly 
the same functionality, but without modifying to the original source. 
Instead effects are applied in realtime, which obviously will consume 
more CPU time when playbacking and recording, depending on the amout of 
effects applied. (from now I will try to call it "effects" not "filters")

A brief idea what I've got in mind todo:
- Separate ARDOUR::Source peak stuff functionality into another class, 
ARDOUR::PeakFile, in such way it will be posible to have several peak 
files asociated to the same source. What I want is to have one peak-file 
for each region. Then when effects are applied the peak file will be 
modified to be able to see the changes on the wave on screen. (Yes! in a 
destructive way modify the peak-file, but I guess that is OK)
- Add some new interfaces to libardour:
     ARDOUR::AudioEffect - which is just a pure abstract interface, will 
have some few methods like: start(), length() , process (Sample * 
samples, Source * source, start, cnt)
    ARDOUR::AudioEffectList - which will just be cointainer class for 
AudioEffect instances, some simple methods like: add_effect(...), 
remove_effect(...) and effect_at (frame_position) which i will try to 
implement in some smart way which it dont have to loop throug all 
registered AudioEffects on each call.
 ARDOUR::SilenceEffect , ARDOUR::AmplifyEffect, ARDOUR::ReverseEffect, 
 implement effect procesing in this AudioEffect subclasses
- Changes in ARDOUR::Region class:
 add a new member ARDOUR::AudioEffectList effect_list
 add  a new member ARDOUR::PeakFile peak_file
 add some new functions like: apply_effect (ARDOUR::AudioEffect, start, 
length), and remove_effect (ARDOUR::AudioEffect)
 the read(...) function will transparantly in some magic way process all 
effects, and return the samples.

Thing that I dont have any idea about howto implement yet:
- support for Undo/Redo should be implemented somewhere, I guess with 
this aproach it will not be too dificult.
- in some how all this new data should be saved with the session, and 
restored when open again, probably not very dificult, with that great 
XML engine.

What I like with this idea is that the day when you run out of CPU 
power, course there's too many effect to process, then you just 
"flattern" the region and you got a new region with all effect applied 
to the new source file.

I just want to have some feedback about the idea before start hacking -:)

/Benny



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
