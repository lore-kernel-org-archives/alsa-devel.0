From: Arek Korbik <arek.korbik@eee.strath.ac.uk>
Subject: Re: How do create a dummy device for recording audio?
	 Does it exist already?
Date: Thu, 22 Apr 2004 21:33:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1082665995.2539.28.camel@deeli.eee.strath.ac.uk>
References: <4087CC4B.80402@crome.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4087CC4B.80402@crome.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Caleb Crome <alsa@crome.org>
Cc: ALSA Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-04-22 at 14:44, Caleb Crome wrote:
> I'd like to create a dummy audio device that can record the PCM data 
> written to it into a file.  So, the dummy device would appear as a sound 
> card to the audio program (Real Player for example), and start dumping 

How about 'file' type plugin? For example:

pcm.file {
    type file
    slave {
        pcm "hw:0,0"
    }
    file "/tmp/file.raw"
}                                                                              
> audio into a file, or maybe it would create another device that could be 
> read simply by 'dd' or some custom command.  Then I'd pipe the data into 

It works with named pipes as well.

http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html#pcm_plugins_file

Arek



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
