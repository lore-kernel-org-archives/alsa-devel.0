From: Paul Davis <pbd@op.net>
Subject: Re: libasound and libpthread
Date: Mon, 29 Jul 2002 12:00:41 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17ZCvd-0001wX-00@usw-sf-list1.sourceforge.net>
References: <3D4545CB.579EA77C@libero.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 29 Jul 2002 15:40:27 +0200."
             <3D4545CB.579EA77C@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Thomas Roeder <rdr@emt.iis.fhg.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Paul Davis wrote:
>> 
>> >I am working with Alsa 0.9.0beta12 version and I am also using posix
>> >threads (libpthread) in my project. In the release version of the
>> >program I link both libraries (libpthread, libasound) dynamically and
>> >everything works well. In the debug version however, I have to do static
>> >linking of the libpthread for proper debugging.
>> 
>> why? i use pthreads a great deal, and i have never had to do this.
>> 
>> and no, libasound does not use pthreads or any other form of threads.
>
>Thomas, you should know to not rely too strong to Paul's words.
>
>He own a big heart, but unfortunately a big mouth too, that he's often
>unable to keep under control ;-)

its true. mea culpa. 

this is what we get for a library containing large chunks of code and
functionality not used by anyone except its author :)

is there anyone on the list except abramo or jaroslav that have ever
used the "shared" PCM device type?

--p



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
