From: Paul Davis <pbd@op.net>
Subject: Re: GUS driver status : multiple open of /dev/dsp ?
Date: Fri, 07 Jun 2002 12:22:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17GMUB-0000Vj-00@usw-sf-list1.sourceforge.net>
References: <20020607163222.A25401@sci.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 07 Jun 2002 16:32:22 +0300."
             <20020607163222.A25401@sci.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ville Syrj l <syrjala@sci.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>On Thu, Jun 06, 2002 at 09:20:31PM -0400, Paul Davis wrote:
>> >The problem with GUS synth is that it uses non-interleaved data layout so
>> >it's not relly useful for pcm stuff. alsa-lib doesn't want to do
>> >the required conversion for some reason.
>> 
>> i find this very suprising and somewhat hard to believe. the
>> hammerfall also uses a non-interleaved data layout (as all the best
>> cards do :), and yet despite the fact that the driver contains no code
>> to handle an interleaved stream, aplay via plughw:N,0 works just
>> fine i.e. alsa-lib handles the conversion perfectly. what makes you
>> think it doesn't work?
>
># aplay -D plughw:0,1 stereo.wav
>aplay: set_params:754: Access type not available

can you try it with the -I option, and also the -m option (in all
combinations)?

--p


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
