From: Paul Davis <pbd@op.net>
Subject: Re: ALSA homepage redesign
Date: Mon, 22 Apr 2002 10:12:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E16zeXZ-0000ZU-00@usw-sf-list1.sourceforge.net>
References: <0GUZ004K22BUKO@l-daemon>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 22 Apr 2002 07:49:41 MDT."
             <0GUZ004K22BUKO@l-daemon>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Thomas Fjellstrom <tfjellstrom@shaw.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> and testing a few changes), so it'll be clear that the API is finished and
>> code is working.
>
>It is? Last time I tried using Rawmidi on an emu10k1 chip I got no sound. I 
>had a soundfont loaded, and tried with my own code and the rawmidi demo 
>source. Midi would play with the pmidi program. I've mentioned it once 
>before, nothing came of it, so Im mentioning it again. :)

most people don't understand that there is a total of about 2 people
working on ALSA at any one time. ALSA is not a large, distributed
project team: it consists of Jaroslav and right now Takashi, with
occasional contributions from driver writers and application
developers who wade into the ALSA source code.

when problems get reported with particular chipsets/audio interfaces,
there is no large group of developers from which one might hope for a
volunteer to study the bug. Takashi and Jaroslav both do good work
tracking down such bugs when they have easy access to the hardware in
question and some time, but for most everything else, the bug waits
until someone steps up to fix it. the hope is that with incorporation
into the 2.5 kernel source base, the set of developers who work on
problems like yours will increase.

--p
