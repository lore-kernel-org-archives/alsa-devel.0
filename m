From: Rimas Kudelis <rq@akl.lt>
Subject: Re: hda-intel and Acer TravelMate 4062 LMi
Date: Fri, 03 Mar 2006 17:30:54 +0200
Message-ID: <4408612E.2040205@akl.lt>
References: <1141047723.8504.4.camel@lepetit.gilouweb.com> from "Gilles          PIÉTRI" at Feb 27, 2006 02:42:03 PM          <200602280132.k1S1WUNu021958@auster.physics.adelaide.edu.au>       <43172.86.203.46.202.1141091943.squirrel@mail.eclaireurs.org>    <39815.81.250.186.122.1141388677.squirrel@mail.eclaireurs.org>    <44083BF6.50205@cr.vu.lt> <51402.81.250.186.122.1141395562.squirrel@mail.eclaireurs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <51402.81.250.186.122.1141395562.squirrel@mail.eclaireurs.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Gilles_PI=C9TRI?= <contact@gilouweb.com>
Cc: Rimas Kudelis <rimas.kudelis@cr.vu.lt>, alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi,

>>>> The subsystem ID is  1025:008f
>>>>
>>> I've updated to CVS, and I think I lost a few things :
>>> Using switches on the previous "test" version, I could switch the line
>>> on,
>>> and the speakers/headphone off (I don't remember how, but I could), I
>>> can't do that anymore.
>>>
>> Do you still load the module with "model=test" option? If you do, I
>> don't quite understand the problems but well, nevermind. Try loading it
>> with a "model=acer" option. You should get much less controls - just
>> those that work (or should work) on an Acer notebook. Set the "Line
>> jack" control to Line In, and the "Mic jack" control to Mic 50pc. Unmute
>> and increase volume in all channels. Try playing some audio file then.
>> If you hear it (the sound should now be redirected to the internal
>> speakers or the headphone jack, if there's anything plugged in). If it
>> works, try loading the module without any parameters and see if your
>> notebook is autodetected, as it should be.
> 
> Well I may have been not clear enough, sorry.
> When I used the model=test thing, on the previous version with the old
> patch, I had a lot of controls I could play with, lot of them inactive or
> weird, and one thing I managed to do was to enable the line out, while
> disabling the internal speakers / headphone. Now with the new version, I
> can't do that anymore. So maybe something was disabled and could still
> bring a "feature". This is not THE important thing, but it could be nice
> to have it if it's possible.

The fact is that Acer's speakers/headphone never worked with the test 
model. ;) They DO work now though, as the test model mixer has 
acquired more controls.


> My notebook is autodected or so do I think, how can I be sure ? (it
> ignores the model=xxx things, and dmesg does not tell me about the model
> the module uses, though I remember seeing this info..

Well basically, if you get the internal speakers/hp jack to work, then 
it's autodetected. If you don't, it's not. Currently, no other model 
supplies initialization strings suitable for Acer. I don't know any 
other way to know which model has been loaded (I'd like to, though)...

BTW, one more thing to consider if you don't get the sound working is 
to rename/delete the mixer settings file (/var/lib/alsa/asound.state 
on Ubuntu) and then to cold-reboot the box (by holding the power 
button for a few seconds). After rebooting, the box should boot with 
the default settings for your model (which should be "acer"). At least 
for me, after Ubuntu automagically unmuted some channels and raised 
volume, the sound worked right out of the box.


>>> I also have a problem with the CD, but I'm not sure it's alsa related :
>>> xmms plays CD silently (no output at all, does not show any sound
>>> activity
>>> while playing), whereas VLC can play CDs fine, but I think it does not
>>> use
>>> ALSA (though configured to output on ALSA), because the CD switch has no
>>> effect on it.
>>>
>> This Audio CD problem has been discussed on the list. I have a suspicion
>> that maybe Acers are expecting your software to do Audio CD decoding (as
>> opposed to the CD drive itself). If you load the module with
>> "model=acer" parameter, you'll see the CD volume control in the mixer.
>> Be aware that it does NOT affect CD playback volume (yet?), so don't get
>> stressed about it. ;)
> 
> OK, not a big deal though, I don't have that much CDs to play ;)

You can still play them with VLC/Gnome CD player/Sound Juicer/whatever...


>> One last thing (just not to miss a silly thing): if you edited the
>> patch_realtek.c previously, you should rename/delete, and then retrieve
>> a fresh copy of it from the CVS, because simple "cvs update" won't
>> retrieve it for you if you have edited it before.
> 
> No problem, it was in another directory, and the patch was properly
> updated ;)

I hope it was.

see ya,
RQ


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
