From: Caleb Crome <alsa@crome.org>
Subject: Re: How do create a dummy device for recording audio?
  Does it exist already?
Date: Thu, 22 Apr 2004 14:24:30 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4088380E.7070004@crome.org>
References: <4087CC4B.80402@crome.org> <1082665995.2539.28.camel@deeli.eee.strath.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1082665995.2539.28.camel@deeli.eee.strath.ac.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arek Korbik <arek.korbik@eee.strath.ac.uk>
Cc: Caleb Crome <alsa@crome.org>, ALSA Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Arek,
    That looks like what I want.  However, I'm sorry to be such an 
ignoramus -- what do I do with that bit of configuration data?  I found 
the /usr/share/alsa/alsa.conf, and there is a similar pcm.file entry in 
that, but it seems to take parameters.  Since I have no sound card, how 
do I configure my system to use the dummy PCM driver and use the 
pcm.file plugin? 

Sorry to the developer community -- this is a user question.  I'll move 
the thread over there if it continues on. 

Thanks,
    -Caleb


Arek Korbik wrote:

>On Thu, 2004-04-22 at 14:44, Caleb Crome wrote:
>  
>
>>I'd like to create a dummy audio device that can record the PCM data 
>>written to it into a file.  So, the dummy device would appear as a sound 
>>card to the audio program (Real Player for example), and start dumping 
>>    
>>
>
>How about 'file' type plugin? For example:
>
>pcm.file {
>    type file
>    slave {
>        pcm "hw:0,0"
>    }
>    file "/tmp/file.raw"
>}                                                                              
>  
>
>>audio into a file, or maybe it would create another device that could be 
>>read simply by 'dd' or some custom command.  Then I'd pipe the data into 
>>    
>>
>
>It works with named pipes as well.
>
>http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html#pcm_plugins_file
>
>Arek
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
>For a limited time only, get FREE Ground shipping on all orders of $35
>or more. Hurry up and shop folks, this offer expires April 30th!
>http://www.thinkgeek.com/freeshipping/?cpg=12297
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>  
>



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
