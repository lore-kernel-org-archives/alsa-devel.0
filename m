From: Roberto De Leo <deleo@unica.it>
Subject: AWE ISA correction + a new question
Date: Thu, 06 Mar 2003 14:32:41 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E675C09.4010609@unica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
the user that had reported a code CTL00e3 told me that he had made a 
mistake and that the code was actually CTL00c3, so the problem 
disappeared. Sorry about that!

Still, I have a question about the isa cards autodetection.
I first tried the isapnpmodules.c program but for some reason it was 
unable to detect anything.
At that point, I wrote the following shell script modifying a similar 
script I found for pci modules:

<----------------------------------------------------

##############################################
#     Detect & load ISA modules              #
##############################################

get_isapnp_modules () {
    while read IGNORE ID IGNORE
        do
          DEVICE="0x"`echo $ID | cut -b6-7``echo $ID | cut -b4-5`
          cat /lib/modules/`uname -r`/modules.isapnpmap | awk "{ if ( 
\$3 ~ /$DEVICE/ ) print \$1 }"
        done
}

for MODULE in `get_isapnp_modules < /proc/bus/isapnp/devices | sort -u`
do echo Loading module $MODULE
        modprobe $MODULE
done

----------------------------------------------------->

I know the script is not very clean, I far from being an expert :-)
My question is: does this script seem to you good for identifying the 
isapnp card modules?
I tried on a PC with a "CTL00e4" ISA AWE card but for some odd reason it 
seems not to work on the PC of the user with the "CTL00c3" ISA AWE card.

Incidentally, why the exadecimal pairs identifying the card are switched 
in /proc/bus/isapnp/devices and modules.isapnpmap?

Thanks and sorry again for the previous mistake,
  Roberto De Leo



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
