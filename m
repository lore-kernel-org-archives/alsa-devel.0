From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: HDSP 9652 sync problems cause loud noise in Alsa 0.9.6
Date: Tue, 07 Oct 2003 09:39:46 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310071339.h97DdkEw030254@oud>
References: <1065531980.1993.0.camel@Wizard.knechthome.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 07 Oct 2003 06:06:20 PDT."
             <1065531980.1993.0.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: Anders Torger <torger@ludd.luth.se>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>On Tue, 2003-10-07 at 06:01, Paul Davis wrote:
>> >   I agree that they may be related. Possibly my noise only happens
>> >continuously when trying to sync to an external 48K source, and possibly
>> >this is just a sign of it never syncing. When I set the Pref. Sync. Ref.
>> >to ADAT1 and use AutoSync I get the noise continuously and the Sync
>> >indicator just goes back and forth between lock and no lock. It never
>> >gets to sync which I presume it should.
>> >
>> >   So, Alsa developers, what's this about?
>> 
>> does the input to ADAT1 contain a valid clock signal? the symptoms you
>> have basically say that it doesn't. 
>
>I agree. It does sound that way, but read the thread please. In my
>machine's case I am dual boot and in my description I said this does not
>happen under Windows.

that would suggest that the driver is not setting the clock source
correctly. sync/lock/nolock is done by the h/w, and if the same config
works under windows, my guess it that the hardware has not been setup
under linux the way it is claimed to be.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
