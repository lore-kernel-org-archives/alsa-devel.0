From: Me Eby <meeby@yahoo.com>
Subject: An alsa lib, that works over OSS drivers ?
Date: Mon, 19 Apr 2004 11:01:18 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040419180118.96664.qmail@web41306.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Can't be done that way.  That is why there is an OSS
wrapper for alsa.  The OSS drivers do not support
all of the capabilities that ALSA drivers do.


> 
> Hi!
> 
> I have this idea that migh accelerate the adoption
> of
> ALSA.
> 
> It is a library ( dynamic ) that implements the ALSA
> API ( so to
> applications it looks like
> normal ALSA ), but accesses the hardware over OSS
> drivers. Like this :
> 
> app <--ALSA-API--> this_library <-- OSS-API--> OSS
> driver <---> sound
> hardware
> 
> This means that application writers can write to
> ALSA
> API and be 
> assured
> that their
> code will work on both ALSA and OSS systems.
> 
> The only thing needed is to install this new library
> on the OSS system 
> ( the
> ALSA systems
> will off course work as they are ).
> 
> This new library would have the same name and API as
> the existing alsa
> library.
> 
> How does this sound ? Feasible ?
> 
> Thanks for any reply,
> David Balazic
>
----------------------------------------------------------------------------
> -----------
> David Balazic                     
> mailto:david.balazic@hermes.si
> HERMES Softlab                
> http://www.hermes-softlab.com
> Zagrebska cesta 104            Phone: +386 2 450
> 8851 
> SI-2000 Maribor
> Slovenija


	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
