From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: Re: Alsa-devel digest, Vol 1 #810 - 3 msgs
Date: Tue, 29 Oct 2002 08:44:03 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021029164403.GC776@porky>
References: <E186QHN-0002BE-00@usw-sf-list2.sourceforge.net> <20021029163629.GD1046@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20021029163629.GD1046@draal.physics.wisc.edu>; from bob+alsa-devel@mcelrath.org on Tue, Oct 29, 2002 at 08:36:29 -0800
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bob McElrath <bob+alsa-devel@mcelrath.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.10.29 08:36 Bob McElrath wrote:
> I don't see a debug setting on the modules snd-cs46xx or snd -- is
> this a compile time setting?

    Yes, you set this when you configure the package.  Use the configure
option "--with-debug=detect" for the most verbose debugging output.


> What is the easy way to test playing to the rear pcm channel?

The easy way:  aplay -Dhw:0,1 test.wav

    Just don't forget to unmute and raise the volume for the rear-output.
Also, if you wish to output directly to SPDIF, use:  "aplay -Dhw:0,2".
    
Thanks for testing. ;-)

HTH,
-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
