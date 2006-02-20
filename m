From: Rimas Kudelis <rq@akl.lt>
Subject: Re: [PATCH] hda/alc260: tweak test model input mux labels,
 fix a comment
Date: Mon, 20 Feb 2006 07:36:08 +0200
Message-ID: <43F95548.1000805@akl.lt>
References: <200602200017.k1K0HiRP021736@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602200017.k1K0HiRP021736@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jonathan,

I think you forgot to add ", 0x7" to the last line in the list.

Rimas


> +/* This is a bit messy since the two input muxes in the ALC260 have slight
> + * variations in their signal assignments.  The ideal way to deal with this
> + * is to extend alc_spec.input_mux to allow a different input MUX for each
> + * ADC.  For the purposes of the test model it's sufficient to just list
> + * both options for affected signal indices.  The separate input mux
> + * functionality only needs to be considered if a model comes along which
> + * actually uses signals 0x5, 0x6 and 0x7 for something which makes sense to
> + * record.
> + */
>  static struct hda_input_mux alc260_test_capture_source = {
> -	.num_items = 7,
> +	.num_items = 8,
>  	.items = {
>  		{ "MIC1 pin", 0x0 },
>  		{ "MIC2 pin", 0x1 },
>  		{ "LINE1 pin", 0x2 },
>  		{ "LINE2 pin", 0x3 },
>  		{ "CD pin", 0x4 },
> -		{ "LINE-OUT pin", 0x5 },
> -		{ "HP-OUT pin", 0x6 },
> +		{ "LINE-OUT pin (cap1), Mixer (cap2)", 0x5 },
> +		{ "HP-OUT pin (cap1), LINE-OUT pin (cap2)", 0x6 },
> +		{ "HP-OUT pin (cap2 only) },
>          },
>  };
>  static struct snd_kcontrol_new alc260_test_mixer[] = {
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
