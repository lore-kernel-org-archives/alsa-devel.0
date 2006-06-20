From: "Christophe Osuna" <christophe.osuna@gmail.com>
Subject: latency.c and delay related questions
Date: Tue, 20 Jun 2006 12:10:06 +0200
Message-ID: <b6251a620606200310q7b532513s1aa6542368568460@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1927465384=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1927465384==
Content-Type: multipart/alternative;
	boundary="----=_Part_15775_5762317.1150798206110"

------=_Part_15775_5762317.1150798206110
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am trying to get small delays with my application and I have been
playing with "latency" from alsa-lib/test.

The current delay with "latency" is equal to a minimum (that depends
on the sound card) plus *two* times the period time.  If I disable
manual change of sound card state as described in the patch below the
delay becomes equal to a minimum *higher than the previous* plus *one*
time the period time.

The delay has been measured with an external box plugged on the sound
card.

I would like to mix both settings to get a delay of the lowest minimum
plus one time the period time. But for this I need to understand what
is happening, and more precisely:

* why is snd_pcm_link() mandatory? (no sound otherwise)
* why two buffers of silence and not just one?
* why is there no snd_pcm_start() for the playback device?
* why is the minimum delay lower with manual handling of the sound
card state?

Help is welcome :-)

Thanxs in advance.



--- latency.c.orig      2006-06-20 10:21:57.000000000 +0200
+++ latency.c   2006-06-20 11:06:10.000000000 +0200
@@ -148,11 +148,11 @@
                printf("Unable to determine current swparams for %s: %s\n",
id, snd_strerror(err
));
                return err;
        }
-       err = snd_pcm_sw_params_set_start_threshold(handle, swparams,
0x7fffffff);
-       if (err < 0) {
-               printf("Unable to set start threshold mode for %s: %s\n",
id, snd_strerror(err))
;
-               return err;
-       }
+/*     err = snd_pcm_sw_params_set_start_threshold(handle, swparams,
0x7fffffff); */
+/*     if (err < 0) { */
+/*             printf("Unable to set start threshold mode for %s: %s\n",
id, snd_strerror(err))
; */
+/*             return err; */
+/*     } */
        tick_time_ok = 0;
        if (tick_time > 0) {
                unsigned int time, ttime;
@@ -273,10 +273,10 @@
                exit(0);
        }

-       if ((err = snd_pcm_prepare(phandle)) < 0) {
-               printf("Prepare error: %s\n", snd_strerror(err));
-               exit(0);
-       }
+/*     if ((err = snd_pcm_prepare(phandle)) < 0) { */
+/*             printf("Prepare error: %s\n", snd_strerror(err)); */
+/*             exit(0); */
+/*     } */

        snd_pcm_dump(phandle, output);
        snd_pcm_dump(chandle, output);
@@ -646,27 +646,27 @@
                showlatency(latency);
                if (tick_time_ok)
                        printf("Using tick time %ius\n", tick_time_ok);
-               if ((err = snd_pcm_link(chandle, phandle)) < 0) {
-                       printf("Streams link error: %s\n",
snd_strerror(err));
-                       exit(0);
-               }
-               if (snd_pcm_format_set_silence(format, buffer,
latency*channels) < 0) {
-                       fprintf(stderr, "silence error\n");
-                       break;
-               }
-               if (writebuf(phandle, buffer, latency, &frames_out) < 0) {
-                       fprintf(stderr, "write error\n");
-                       break;
-               }
-               if (writebuf(phandle, buffer, latency, &frames_out) < 0) {
-                       fprintf(stderr, "write error\n");
-                       break;
-               }
-
-               if ((err = snd_pcm_start(chandle)) < 0) {
-                       printf("Go error: %s\n", snd_strerror(err));
-                       exit(0);
-               }
+/*             if ((err = snd_pcm_link(chandle, phandle)) < 0) { */
+/*                     printf("Streams link error: %s\n",
snd_strerror(err)); */
+/*                     exit(0); */
+/*             } */
+/*             if (snd_pcm_format_set_silence(format, buffer,
latency*channels) < 0) { */
+/*                     fprintf(stderr, "silence error\n"); */
+/*                     break; */
+/*             } */
+/*             if (writebuf(phandle, buffer, latency, &frames_out) < 0) {
*/
+/*                     fprintf(stderr, "write error\n"); */
+/*                     break; */
+/*             } */
+/*             if (writebuf(phandle, buffer, latency, &frames_out) < 0) {
*/
+/*                     fprintf(stderr, "write error\n"); */
+/*                     break; */
+/*             } */
+
+/*             if ((err = snd_pcm_start(chandle)) < 0) { */
+/*                     printf("Go error: %s\n", snd_strerror(err)); */
+/*                     exit(0); */
+/*             } */
                gettimestamp(phandle, &p_tstamp);
                gettimestamp(chandle, &c_tstamp);
 #if 0

------=_Part_15775_5762317.1150798206110
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>
<br>
I am trying to get small delays with my application and I have been<br>
playing with &quot;latency&quot; from alsa-lib/test.<br>
<br>
The current delay with &quot;latency&quot; is equal to a minimum (that depends<br>
on the sound card) plus *two* times the period time.&nbsp; If I disable<br>
manual change of sound card state as described in the patch below the<br>
delay becomes equal to a minimum *higher than the previous* plus *one*<br>
time the period time.<br>
<br>
The delay has been measured with an external box plugged on the sound<br>
card.<br>
<br>
I would like to mix both settings to get a delay of the lowest minimum<br>
plus one time the period time. But for this I need to understand what<br>
is happening, and more precisely:<br>
<br>
* why is snd_pcm_link() mandatory? (no sound otherwise)<br>
* why two buffers of silence and not just one?<br>
* why is there no snd_pcm_start() for the playback device?<br>
* why is the minimum delay lower with manual handling of the sound <br>
card state?<br>
<br>
Help is welcome :-)<br>
<br>
Thanxs in advance.<br>
<br>
<br>
<br>
--- latency.c.orig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-06-20 10:21:57.000000000 +0200<br>
+++ latency.c&nbsp;&nbsp; 2006-06-20 11:06:10.000000000 +0200<br>
@@ -148,11 +148,11 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(&quot;Unable to determine current swparams for %s: %s\n&quot;, id,
snd_strerror(err<br>
));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = snd_pcm_sw_params_set_start_threshold(handle, swparams, 0x7fffffff);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(&quot;Unable to set start threshold mode for %s: %s\n&quot;, id,
snd_strerror(err))<br>
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp; err = snd_pcm_sw_params_set_start_threshold(handle, swparams, 0x7fffffff); */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0) { */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(&quot;Unable to set start threshold mode for %s: %s\n&quot;, id,
snd_strerror(err))<br>
; */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err; */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp; } */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tick_time_ok = 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tick_time &gt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int time, ttime;<br>
@@ -273,10 +273,10 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((err = snd_pcm_prepare(phandle)) &lt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(&quot;Prepare error: %s\n&quot;, snd_strerror(err));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp; if ((err = snd_pcm_prepare(phandle)) &lt; 0) { */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Prepare error: %s\n&quot;, snd_strerror(err)); */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(0); */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp; } */<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_dump(phandle, output);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_dump(chandle, output);<br>
@@ -646,27 +646,27 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; showlatency(latency);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tick_time_ok)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(&quot;Using tick time %ius\n&quot;, tick_time_ok);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if ((err = snd_pcm_link(chandle, phandle)) &lt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(&quot;Streams link error: %s\n&quot;, snd_strerror(err));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
exit(0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (snd_pcm_format_set_silence(format, buffer, latency*channels) &lt;
0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
fprintf(stderr, &quot;silence error\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (writebuf(phandle, buffer, latency, &amp;frames_out) &lt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
fprintf(stderr, &quot;write error\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (writebuf(phandle, buffer, latency, &amp;frames_out) &lt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
fprintf(stderr, &quot;write error\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if ((err = snd_pcm_start(chandle)) &lt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(&quot;Go error: %s\n&quot;, snd_strerror(err));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
exit(0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if ((err = snd_pcm_link(chandle, phandle)) &lt; 0) { */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(&quot;Streams link error: %s\n&quot;, snd_strerror(err)); */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
exit(0); */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (snd_pcm_format_set_silence(format, buffer, latency*channels) &lt;
0) { */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
fprintf(stderr, &quot;silence error\n&quot;); */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
break; */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (writebuf(phandle, buffer, latency, &amp;frames_out) &lt; 0) { */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
fprintf(stderr, &quot;write error\n&quot;); */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
break; */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (writebuf(phandle, buffer, latency, &amp;frames_out) &lt; 0) { */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
fprintf(stderr, &quot;write error\n&quot;); */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
break; */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } */<br>
+<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((err = snd_pcm_start(chandle)) &lt; 0) { */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(&quot;Go error: %s\n&quot;, snd_strerror(err)); */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
exit(0); */<br>
+/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gettimestamp(phandle, &amp;p_tstamp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gettimestamp(chandle, &amp;c_tstamp);<br>
&nbsp;#if 0<br>
<br>

------=_Part_15775_5762317.1150798206110--


--===============1927465384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1927465384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1927465384==--
