From: Josh Green <jgreen@users.sourceforge.net>
Subject: Re: documentation - yeah right!
Date: 20 May 2003 13:31:08 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053462667.2171.27.camel@SillyPuddy>
References: <PM.9386.1053461408@pmweb11.uk1.bibliotech.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <PM.9386.1053461408@pmweb11.uk1.bibliotech.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: cliff@postmaster.co.uk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-05-20 at 13:10, Cliff Bradshaw wrote:
> If alsa is supposed to be so profesional, why does it have no decent documentation?
> 
> I have searched the whole internet and still cant find any proper documentation on how to use the fscking sequencer interface!
> 
> sure there is the howto by Matthias Nagorni, (thank god *someone* is writing docs for the seuqncer!) but I want to see a proper API reference
> 
> doxygen is just an excuse to avoid writing documentation and should be banned from all projects. If I want a list of all the damn globals I'll look in the source code thankyou.
> 
> seriously though. Alsa is great, but is not going to suceed unless we know how to use it.  OSS has pretty good documentation and it will continue to be the standard linux audio api unless we tell people how to use alsa!!!!!!!!!
> 

Perhaps you are being confused with how to navigate the doxygen
reference (a rather easy thing to do). If this is the case, try going to
the "File List" link at the top of the ALSA library reference and then
click on seq.c in the list and you will see all the routines used for
the sequencer. Clicking on one will give you more details. The only
thing I find a little annoying by the reference docs is that the pages
are so huge (perhaps because most routines are documented :).

Another good source of reference would be to take a look at some example
programs (there are some in the "test" directory in the alsa-lib
source).

Your request for help is less likely to succeed with the tone in which
you are writing, though. Keep in mind that many of the individuals
working on this are doing so in their spare time, because they like
doing it. Its people that bad mouth this that are more likely to cause
it to not succeed than anything else, free software developers like to
be appreciated for their work. Cheers.
	Josh Green



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
