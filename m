From: Dan Tihelka <dtihelka@kky.zcu.cz>
Subject: Confirm the number of played samples?
Date: Wed, 07 Jan 2004 15:25:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FFC16EA.2050506@kky.zcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Dear ALSA developers,

i am sorry to disturb you with my own problem, but i would like to ask 
you for advice with confirming the number of samples played.
There is the description of the problem:


We have been developping speech synthesis system at our university ans 
naturally we need to play the synthetic speech.
Syntesis generates the array of speech samples for whole sentence (like 
"hallo") and boundaries of
particular phonemes in it (the duration of phonemes varies 
approximatelly from 30ms to 150ms or sometimes more). It can be shown like:

|  h    |      a     |     l    |    ow    |
0     0.15       0.6     0.78      1.06    <-- the time of phoneme 
boundary in generated speech (in sec.)

Then we have Player module, which stores whole speech buffer within 
together with the duration
of particular phonemes in the sentence and plays generated speech in 
non-blocking way. Another very important task of
Player module is to confirm each played phoneme, whenever  number of 
samples corresponding to its duration were played (it is done by calling 
a specified function registered to Player). For the previous example it 
would be when 2400, 9600, 12480,
and 16960 samples were played:


    Synthesis                                                      
Player module

 |   Generate speech 1 (hallo)    
 |   Copy to Player                                              Start 
to play speech 1
 |   Generate speech 2 (hallo)                                    
confirm h   
 |   Copy to Player                                                    
confirm a
 |   Generate speech 3 (hallo)                                    
confirm l   
 |   copy to Player                                                     
confirm ow      Start to play speech 2 immediately
 |   wait until something                                              
confirm h
 |                                                                      
        confirm a
 |                                                                      
        confirm l
 |                                                                      
        confirm ow      Start to play speech 3 immediately
 |                                                                      
        confirm h   
 |                                                                      
        confirm a
 |                                                                      
        confirm l
 |                                                                      
        confirm ow
\|/                                                                   
      wait for other speech ....

time


It works under windows satisfiable (because we implemented it under 
windows at first, but it was not my work) and now
we want to implement it under linux (most of the code is ANSI C++). 
Naturally, we choose ALSA, byt i have no idea how to
implement described behaviour of Player module.

I found some examples how to use ALSA and ALSA library interface, but 
none of them deal with playing sound buffers
with variable length and confirming, that a buffer is processed 
(played). Could you help me and give me some idea how
it could be implemented? How to work with buffers and what to send to 
snd_pcm_writei() method? How can i recognize, that
a number of samples was played?

Thank you very much for your help and time

DT.



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
