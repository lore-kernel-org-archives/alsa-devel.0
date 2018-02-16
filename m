From: "Mohammad, Jamal M" <MohammadJamal.Mohiuddin@ncr.com>
Subject: WM8985 Machine Driver Write Error
Date: Fri, 16 Feb 2018 03:52:06 +0000
Message-ID: <CY1PR15MB0126A96EEDB08977C02EAD19F0CB0@CY1PR15MB0126.namprd15.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7599803161074383573=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-00209e01.pphosted.com (mx0a-00209e01.pphosted.com
 [148.163.148.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 94D26267D4E
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 04:52:11 +0100 (CET)
Received: from pps.filterd (m0131214.ppops.net [127.0.0.1])
 by mx0b-00209e01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1G3nR4d024861
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 22:52:10 -0500
Received: from nam03-by2-obe.outbound.protection.outlook.com
 (mail-by2nam03lp0054.outbound.protection.outlook.com [216.32.180.54])
 by mx0b-00209e01.pphosted.com with ESMTP id 2g5nnxrect-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 22:52:10 -0500
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============7599803161074383573==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_004_CY1PR15MB0126A96EEDB08977C02EAD19F0CB0CY1PR15MB0126namp_";
	type="multipart/alternative"

--_004_CY1PR15MB0126A96EEDB08977C02EAD19F0CB0CY1PR15MB0126namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Guys,

We have a custom i.MX6 Board which has WM8985 audio codec. I developed mach=
ine level driver ( imx-wm8985.c ) looking at imx-wm8962 code. Driver loads =
fine without any error. "aplay -L" list the sound card. I2C interface works=
 fine but it is write only peripheral.

But when I am trying to play a Wav file using aplay, it fails with "aplay: =
pcm_write:1939: write error: Input/output error".

Reading Online found that this happens when routing is incorrect. I am unab=
le to proceed after this..Please help me to fix this issue.

Here is my device tree.

sound {
                compatible =3D "fsl,imx6q-sabresd-wm8985",
                           "fsl,imx-audio-wm8985";
                model =3D "wm8985-audio";
                cpu-dai =3D <&ssi2>;
                audio-codec =3D <&codec>;
                audio-routing =3D
                        "Ext Spk", "SPKL",
                        "Ext Spk", "SPKR";
                mux-int-port =3D <2>;
                mux-ext-port =3D <3>;
        };

Please provide me clue/hint to proceed and solve the issue. I can provide y=
ou more details if you need.

Thanks for your help.


Mohammad Jamal Mohiuddin
Software Engineer, Retail Hosp/HW
NCR Corporation India Pvt Ltd.
MohammadJamal.Mohiuddin@ncr.com | www.ncr.com<http://www.ncr.com>





--_004_CY1PR15MB0126A96EEDB08977C02EAD19F0CB0CY1PR15MB0126namp_
Content-Type: image/jpeg; name="Picture (Device Independent Bitmap) 1.jpg"
Content-Description: Picture (Device Independent Bitmap) 1.jpg
Content-Disposition: inline;
	filename="Picture (Device Independent Bitmap) 1.jpg";
	creation-date="Fri, 16 Feb 2018 03:52:04 GMT";
	modification-date="Fri, 16 Feb 2018 03:52:04 GMT"
Content-ID: <C5BEB683B3DE2E448A56792BABCD658C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0a
HBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCABKAEoDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDIeS4M
zgTzfe9TUiyXI586Y/8AAjVx7cLM+ST83enLGN2MN+VeO6jPHsysr3Bz+/mGT/eNOBuAwPnzcH1N
XVh5z830xUghORwcd+Kz9q11JsUh9p2gfaJuufvGnqZ1OPOm59zV8QfWnLBz95vyFT7YmyTKQNx/
z3l/76NGbggZml/BjWj5PsaDD7Gp9sBls04H+um/Ak16Pphc6TZku+fITr/uiuHNv/tP+Q/wrvdP
iP8AZtr87f6lOw9B7V1YapzNnRh92efSREzNyfvdKeIx196ldcTScfxVPaabe6hIUsrSW4YMAdpU
BfqSRXE227IXLroV0jBPfrUwTnvWlP4b1q0ZFbTnkMhwojlQ846fe/WnzeFtbiUS/wBnSvu4dEnQ
lRj03Y/Kk6dX+V/cNwl2/MzMEkBUZhnlgRgc/Wja5df3cgAOD93B/XNKFVsoYnGyRgSGHDcg9D65
qdgSAB0Jw3ODjHb9Kw5tRNrsRCBs5MrYz90AY/lmpdoxTiQNox1P5UzzFXy1RCykcFcYAqbtktpb
kRhYL9+Qkf7vP6V3Gnj/AIltrkEfuU4P0FcduDYIOQRwRXa2P/IPtv8Arkv8hXbg5PmZvRtdnncv
33/3q6m4L6P4LtIrIyxS38ymWaOTDAkgfezwMAdOgzXLSH963+9W5pWr2H9lPpGrw3MtuZt8ciNz
F0OM5zjPp64qacoptN2bQ49UdVpNl/Ztn5bXNxcTE7priSZpNoI+6pY/Tp61k6z9p0bU7TUbe5ul
M8xVrV7h2G3DHcVyR6fnTrbWND0SDy7We9vcy71R23LESMdz09veomu/DguRqVxLfXtx5hcRlzwe
eAC2No9P0rrqTi4csZJP12/zNnblSVv8ibUtOs5PF+nhoD5d2rySx7iOfLZs9euRVO00WLZd3MZa
ayYN5UjScxtvPBGeoyR6cVkza9dz6x/aYR45BI6xRuRwu1gB19KgW6niMgjacLIWDosnysCPTP5e
9ccqlNyb5er/AMvu3/zMeeEnzGreXEGkXK2EGlCRY1G6adt5c4z1LZ5q9BZ7tN0r7Fptq1xPHIWW
dgGGCuAOcd+1Y8Gq3EcEcUyxXPlk+W0672Uc45PPSoZ9Ru51tg279wrlTE20qWK5wcj0/So9tBtr
v5LTVdfQV1bmf/DFnVUs2uoUto2QiIefskO0SdwOenJ/KursBjTrYDPES9T7CuCN3cXzQzXcTxzi
LZJhhhzxljg9eOvua7qw5061ODzEnf2Fb4V3qSKpWbckjzyQ/vH+tAb61C/DsAMAHAApQR6CsnEz
JgQT0P4mpA2QCVOR0qsDjpxTwajlHcnOGKE5+U5H1wR/WmBVBBHm8esh/wAabvpN9CTJ5YvdE5bK
kc8jsaVWOwZJJx1NV8r6CkAUHhR+VS4voVoWN3seP1rutPb/AIltrwf9Sn8hXnxc+grvtOb/AIll
p/1xT+QrswkfeZpSep5pNtaVsgH5u4pQ5rtWsLPe3+iQdf8AnmKb/Z9lnP2O3/79D/CnKnbqRynG
iRs9Bj61JvHfHNdf/Z1ljH2O3x/1yX/ClFhZcf6JB1/55j/Co5NBW1OP3DrgUu6uw+wWfH+iQdf+
eY/wpfsFn/z6Qf8AfsU1TurhynGmTtxzxRuHpXY/2fZf8+dv/wB+l/wo+w2f/PpB/wB+xUwjzg4n
FmQ44A/HivQ9Nb/iV2f/AFwT/wBBFZ50+y/59Lf/AL9D/CuntIIVs4AIowBGoACjjiuyhCzZpSR/
/9k=

--_004_CY1PR15MB0126A96EEDB08977C02EAD19F0CB0CY1PR15MB0126namp_--

--===============7599803161074383573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7599803161074383573==--
