From: Patrice Tisserand <Patrice.Tisserand@ircam.fr>
Subject: Re: unresolved symbol in "insmod snd-ens1371"
Date: 13 Oct 2003 11:40:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066038016.3840.72.camel@localhost.localdomain>
References: <002401c39096$0ac3bcc0$987ba8c0@Vectra>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <002401c39096$0ac3bcc0$987ba8c0@Vectra>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Frank H." <frankcch@comcast.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-10-12 at 09:54, Frank H. wrote:
> Hi,
>  
> I have Linux PC with
> OS: linux 9.0
> sound card: Create Lab Sound blaster 16 PCI.
> PC: Compaq Presario
> Alsa driver: 0.9.7.a
>  
> Why there so many unresolved synbol when load the snd-ens1371
> ("insmod snd-ens1371")?
> Is there any mistakes during image buit?
>  
> I follow the procedures in this link
>  
> http://www.alsa-project.org/alsa-doc/doc-php/template.php3?company=Creative+Labs&card=Soundblaster+16+PCI&chip=ES1373&module=ens1371
>  
> form  http://www.alsa-project.org/,
>  
>  
Hi, 
insmod will only load the module given as parameter.
So it will not load the module required by snd-ens1371.
Please try: modprobe snd-send1371 instead.
I think it will fix your problem.

Bye.
-- 
Patrice Tisserand <Patrice.Tisserand@ircam.fr>



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
